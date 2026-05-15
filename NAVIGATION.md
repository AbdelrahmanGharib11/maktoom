# Maktom — Flutter Navigation Spec
> Framework: Flutter + go_router
> Tab strategy: `StatefulShellRoute.indexedStack` (preserves per-tab history)
> Drop this file in your project root. Reference it with `@NAVIGATION.md` in every Antigravity prompt that touches routing or screen implementation.

---

## Router Architecture

```
GoRouter (root)
│
├── /splash                        → SplashPage           [AuthStack]
├── /onboarding                    → OnboardingPage        [AuthStack, 3-slide carousel]
├── /login                         → LoginPage            [AuthStack]
├── /signup                        → SignUpPage           [AuthStack]
├── /verify-email                  → EmailVerificationPage [AuthStack]
├── /gift/redeem/:code             → GiftRedemptionScreen [standalone, no auth needed]
│
├── /app  ← standalone GoRoute, redirect only: (_, __) => '/app/home'
│          StatefulShellRoute does NOT own this path
│
└── StatefulShellRoute.indexedStack  ← owns branch root paths directly
      ├── branch 0: /app/home          → HomeStack
      ├── branch 1: /app/therapists    → TherapistsStack
      ├── branch 2: /app/journal       → JournalStack
      ├── branch 3: /app/circles       → CirclesStack
      └── branch 4: /app/profile       → ProfileStack
```

**Path convention:**
- `context.push()` / `context.go()` calls always use **full absolute paths**: `context.push('/app/therapists/$id')`
- `GoRoute` definitions inside a parent use **relative child paths** (no leading `/`):
  ```dart
  GoRoute(
    path: '/app/therapists',
    routes: [
      GoRoute(path: ':therapistId'),        // ✅ relative
      GoRoute(path: 'quiz/q1'),             // ✅ relative
    ],
  )
  ```
- Never use relative paths in navigation calls and never use absolute paths in child `GoRoute` definitions.

---

**Auth guard:** GoRouter `redirect` checks auth state on every route.

| Condition | Result |
|---|---|
| Unauthenticated + protected route | → `/splash` |
| Unauthenticated + `/splash`, `/onboarding`, `/login`, `/signup`, `/verify-email`, `/gift/redeem/:code` | → allow (no redirect) |
| Authenticated + any auth route (`/splash`, `/onboarding`, `/login`, `/signup`) | → `/app/home` |
| Authenticated + `/verify-email` | → `/app/home` only if email is verified; stay on `/verify-email` if not yet verified |
| Navigate to `/app` (shell root) | → `/app/home` |

> This prevents `/onboarding`, `/login`, and `/signup` from incorrectly redirecting back to `/splash` when the user is unauthenticated.

---

## Auth Stack (outside shell — NO bottom tab bar)

| Route            | Page Class                | Notes                          |
|------------------|---------------------------|--------------------------------|
| `/splash`        | `SplashPage`              | Entry point, auto-redirects    |
| `/onboarding`    | `OnboardingPage`          | 3 slides, replaces WelcomePage |
| `/login`         | `LoginPage`               |                                |
| `/signup`        | `SignUpPage`              |                                |
| `/verify-email`  | `EmailVerificationPage`   | Stay here if authenticated but not yet verified |

- **On auth success:** `context.go('/app/home')` — replaces entire auth stack
- **On logout / delete account:** `context.go('/splash')` — resets to auth stack

---

## Branch 0 — Home Stack `/home`

Tab bar **visible** on HomeScreen only. **Hidden** on all nested routes.

```
/app/home                           → HomeScreen              (tab root)
/app/home/check-in                  → QuickCheckInScreen      (push)
/app/home/session-prep              → SessionPrepCardScreen   (push)
/app/home/intake/entry              → AIIntakeEntryScreen     (push)
/app/home/intake/chat               → AIIntakeChatScreen      (push, hide tab bar)
/app/home/intake/summary            → AIIntakeSummaryScreen   (push)
/app/home/waiting-room/:sessionId   → WaitingRoomScreen       (push, hide tab bar)
```

**Flow:**
```
HomeScreen
  ├── [mood emoji] → /check-in → /session-prep → /intake/entry → /intake/chat
  │                                                                    → /intake/summary
  │                                                                         → context.go('/app/home')
  └── [Upcoming Session card] → /waiting-room/:sessionId
```

---

## Branch 1 — Therapists Stack `/therapists`

Tab bar **visible** on TherapistsScreen only. **Hidden** on all nested routes.

```
/app/therapists                              → TherapistsScreen           (tab root)
/app/therapists/quiz/q1                      → MatchQuizQ1Screen          (push — static)
/app/therapists/quiz/q2                      → MatchQuizQ2Screen          (push — static)
/app/therapists/quiz/q3                      → MatchQuizQ3Screen          (push — static)
/app/therapists/quiz/results                 → MatchQuizResultsScreen     (push — static)
/app/therapists/gift                         → GiftSessionEntryScreen     (push — static)
/app/therapists/gift/share                   → GiftLinkShareScreen        (push — static)
/app/therapists/session/:id/waiting          → WaitingRoomScreen          (push, hide tab bar — static prefix)
/app/therapists/session/:id/active           → ActiveSessionScreen        (push, hide tab bar, full-screen)
/app/therapists/session/:id/feedback         → PostSessionFeedbackScreen  (push, hide tab bar)
/app/therapists/session/:id/tasks            → PostSessionMicroTasksScreen(push, hide tab bar)
/app/therapists/:therapistId                 → TherapistProfileScreen     (push — dynamic, must come last)
/app/therapists/:therapistId/book            → BookSessionScreen          (push, hide tab bar)
/app/therapists/:therapistId/confirm         → BookingConfirmationScreen  (push, hide tab bar)
```

> **CouplesModeSelector** is NOT a route. It is a `showModalBottomSheet` triggered on TherapistsScreen when the couples toggle is tapped. Dismissed with `Navigator.pop()`.

**Flow:**
```
TherapistsScreen
  ├── [couples toggle] → CouplesModeSelector (modal, not a route)
  │       └── [Continue] → pop + apply filter to TherapistsScreen
  │
  ├── [Find a Match] → /quiz/q1 → /quiz/q2 → /quiz/q3 → /quiz/results → /:therapistId
  │
  └── [therapist card] → /:therapistId → /book → /confirm
                                                → context.push('/app/therapists/session/:id/waiting')
                                                       → /active → /feedback → /tasks
                                                                                    → context.go('/app/home')
```

---

## Branch 2 — Journal Stack `/journal`

Tab bar **visible** on MoodJournalScreen only.

```
/app/journal                        → MoodJournalScreen          (tab root)
/app/journal/new                    → NewJournalEntryScreen      (push — static, must come before /:entryId)
/app/journal/insights               → MoodTrendInsightsScreen    (push — static, must come before /:entryId)
/app/journal/:entryId               → JournalEntryDetailScreen   (push — dynamic)
/app/journal/:entryId/prep-note     → ExpandedPrepNoteScreen     (push — NOT a modal)
```

> **Clarification:** `ExpandedPrepNoteScreen` is a push route, not a modal. It has a Save Note action and back navigation.

---

## Branch 3 — Circles Stack `/circles`

Tab bar **visible** on CommunityCirclesScreen only.

```
/app/circles                        → CommunityCirclesScreen     (tab root)
/app/circles/:circleId              → CircleDetailScreen         (push)
```

Circle slugs: `work-stress`, `parenting-pressure`, `relationships`, `grief-loss`, `identity-growth`

---

## Branch 4 — Profile Stack `/profile`

Tab bar **visible** on ProfileScreen only.

```
/app/profile                        → ProfileScreen              (tab root)
/app/profile/resources              → ResourceLibraryScreen      (push)
/app/profile/gift                   → GiftSessionEntryScreen     (push)
/app/profile/gift/share             → GiftLinkShareScreen        (push)
/app/profile/success-story          → SubmitSuccessStoryScreen   (push)
/app/profile/audio-upload           → TherapistAudioUploadScreen (push, therapist role only)
```

> **Clarification:** `ResourceLibraryScreen` lives under ProfileStack — it contains personal wellness tools, not therapist discovery.

> **Clarification:** `VoicePreviewPlayerModal` is a `showModalBottomSheet` only — NOT a push route. Triggered from ResourceLibraryScreen or TherapistAudioUploadScreen.

---

## Global Modals (no route — programmatic only)

| Modal                   | Widget Class                | Trigger                              | Dismiss                              |
|-------------------------|-----------------------------|--------------------------------------|--------------------------------------|
| Crisis Support          | `CrisisSupportModal`        | AI distress detection or SOS tap     | "I'm okay" (pop) or "Talk to someone" → push ActiveSession |
| Couples Mode Selector   | `CouplesModeSelector`       | Couples toggle on TherapistsScreen   | Cancel (pop) or Continue (pop + filter) |
| Voice Preview Player    | `VoicePreviewPlayerModal`   | Play tap on audio resource           | Close (×) → pop                     |

---

## Full-Screen Routes (hide bottom tab bar)

```
ActiveSessionScreen          ← full-screen, hide tab bar + system UI chrome
WaitingRoomScreen            ← hide tab bar
CouplesWaitingRoomScreen     ← hide tab bar
BookSessionScreen            ← hide tab bar
BookingConfirmationScreen    ← hide tab bar
PostSessionFeedbackScreen    ← hide tab bar
PostSessionMicroTasksScreen  ← hide tab bar
AIIntakeChatScreen           ← hide tab bar
```

---

## Deep Links

| URI Pattern               | GoRouter Route                               | Auth required |
|---------------------------|----------------------------------------------|---------------|
| `maktom://gift/:code`     | `/gift/redeem/:code` (standalone, no shell)  | No            |
| `maktom://session/:id`    | `/app/therapists/session/:id/waiting`        | Yes           |
| `maktom://therapist/:id`  | `/app/therapists/:id`                        | Yes           |
| `maktom://journal/new`    | `/app/journal/new`                           | Yes           |

---

## Migration Plan: Flat → StatefulShellRoute

Current app uses flat GoRouter. Steps to migrate without breaking existing pages:

```
Step 1: Add StatefulShellRoute.indexedStack wrapping all 5 tab branches
Step 2: Move existing flat routes (/, /therapists, /journal, /circles, /profile)
        under their respective branch roots (/app/home, /app/therapists, etc.)
Step 3: Move /splash and /onboarding OUTSIDE the shell as top-level routes
Step 4: Add GoRouter redirect() for auth guard
Step 5: Replace `context.go('/therapists')` tab taps with `navigationShell.goBranch(index)`
Step 6: Implement tab bar visibility logic — hide shell nav bar on full-screen routes
Step 7: Replace WelcomePage with OnboardingPage (3-slide carousel, existing file)
```

---

## Screen → File Path Mapping

> ⚠️ IMPORTANT — This project uses a **feature-first** Flutter structure.
> - Do NOT create `lib/screens/...`
> - Do NOT create wrapper files just to match Stitch screen names
> - If a matching page already exists, **update that existing file**
> - New pages → `lib/features/<feature>/presentation/pages/`
> - New widgets/modals → `lib/features/<feature>/presentation/widgets/`

| Stitch Screen Name              | Flutter File Path                                                                          |
|---------------------------------|--------------------------------------------------------------------------------------------|
| Splash Screen                   | `lib/features/onboarding/presentation/pages/splash_page.dart`                             |
| Onboarding Carousel             | `lib/features/onboarding/presentation/pages/onboarding_page.dart`                         |
| Onboarding - Verified Experts   | `lib/features/onboarding/presentation/widgets/verified_experts_slide.dart`                 |
| Onboarding - How it Works       | `lib/features/onboarding/presentation/widgets/how_it_works_slide.dart`                     |
| Login Screen                    | `lib/features/auth/presentation/pages/login_page.dart`                                    |
| Sign Up Screen                  | `lib/features/auth/presentation/pages/sign_up_page.dart`                                  |
| Email Verification              | `lib/features/auth/presentation/pages/email_verification_page.dart`                       |
| Home Screen                     | `lib/features/home/presentation/pages/home_page.dart`                                     |
| Quick Check-In                  | `lib/features/home/presentation/pages/quick_check_in_page.dart`                           |
| Session Prep Card               | `lib/features/home/presentation/pages/session_prep_card_page.dart`                        |
| AI Intake - Entry Prompt        | `lib/features/intake/presentation/pages/ai_intake_entry_page.dart`                        |
| AI Intake - Chat Screen         | `lib/features/intake/presentation/pages/ai_intake_chat_page.dart`                         |
| AI Intake - Summary Screen      | `lib/features/intake/presentation/pages/ai_intake_summary_page.dart`                      |
| Therapists                      | `lib/features/therapists/presentation/pages/therapists_page.dart`                         |
| Therapist Profile Detail        | `lib/features/therapists/presentation/pages/therapist_profile_page.dart`                  |
| Couples Mode Selector           | `lib/features/therapists/presentation/widgets/couples_mode_selector.dart`                  |
| Match Quiz - Question 1         | `lib/features/match_quiz/presentation/pages/match_quiz_q1_page.dart`                      |
| Match Quiz - Question 2         | `lib/features/match_quiz/presentation/pages/match_quiz_q2_page.dart`                      |
| Match Quiz - Question 3         | `lib/features/match_quiz/presentation/pages/match_quiz_q3_page.dart`                      |
| Match Quiz Results              | `lib/features/match_quiz/presentation/pages/match_quiz_results_page.dart`                 |
| Book a Session                  | `lib/features/therapists/presentation/pages/booking_page.dart`                            |
| Booking Confirmation            | `lib/features/therapists/presentation/pages/booking_confirmation_page.dart`               |
| Waiting Room Screen             | `lib/features/sessions/presentation/pages/waiting_room_page.dart`                         |
| Couples Waiting Room            | `lib/features/sessions/presentation/pages/couples_waiting_room_page.dart`                 |
| Active Session                  | `lib/features/sessions/presentation/pages/in_session_page.dart`                           |
| Post-Session Feedback           | `lib/features/sessions/presentation/pages/post_session_feedback_page.dart`                |
| Post-Session Micro-Tasks        | `lib/features/sessions/presentation/pages/post_session_micro_tasks_page.dart`             |
| Mood Journal                    | `lib/features/journal/presentation/pages/journal_page.dart`                               |
| New Journal Entry Screen        | `lib/features/journal/presentation/pages/new_journal_entry_page.dart`                     |
| Journal Entry Detail View       | `lib/features/journal/presentation/pages/journal_entry_detail_page.dart`                  |
| Expanded Prep Note              | `lib/features/journal/presentation/pages/expanded_prep_note_page.dart`                    |
| Mood Trend Insights             | `lib/features/journal/presentation/pages/mood_trend_insights_page.dart`                   |
| Community Circles               | `lib/features/circles/presentation/pages/circles_page.dart`                               |
| Circle Detail (all circles)     | `lib/features/circles/presentation/pages/circle_detail_page.dart`                         |
| Profile Screen                  | `lib/features/profile/presentation/pages/profile_page.dart`                               |
| Resource Library                | `lib/features/profile/presentation/pages/resource_library_page.dart`                      |
| Voice Preview Player            | `lib/features/profile/presentation/widgets/voice_preview_player_modal.dart`               |
| Gift a Session Entry            | `lib/features/gifting/presentation/pages/gift_session_entry_page.dart`                    |
| Gift Link Share                 | `lib/features/gifting/presentation/pages/gift_link_share_page.dart`                       |
| Gift Redemption Screen          | `lib/features/gifting/presentation/pages/gift_redemption_page.dart`                       |
| Submit Success Story            | `lib/features/community/presentation/pages/submit_success_story_page.dart`                |
| Crisis Support                  | `lib/features/crisis_protocol/presentation/widgets/crisis_support_modal.dart`             |
| Therapist Audio Upload          | `lib/features/therapists/presentation/pages/therapist_audio_upload_page.dart`             |

---

## Antigravity Prompt Template

```
@NAVIGATION.md @lib/core/services/app_router.dart
Implement [ScreenName] using Stitch MCP.
- Route:         [exact route from this spec]
- Branch:        [home / therapists / journal / circles / profile / auth]
- Tab bar:       visible / hidden
- Navigate in:   context.push('[route]') from [SourceScreen]
- Navigate out:  context.pop() / context.go('[route]')
- Type:          push route / showModalBottomSheet / global modal overlay
```
