# MindSpace

MindSpace is an accessible online mental health platform connecting clients with professional therapists for secure chat consultations. The project provides a safe, user-friendly space for psychological support with therapist search, booking, real-time chat, and user/therapist/admin management.

## Project structure

| Path | Description |
|------|-------------|
| **`App/mindspace_api/`** | Backend API (Laravel) — REST API, WebSockets, admin panel |
| **`App/mindspace_app/`** | Client app (Flutter) — mobile, web, desktop |

## Tech stack

- **Backend:** Laravel 12, PHP 8.2, Laravel Sanctum (API auth), Laravel Reverb (WebSockets)
- **Payments:** Midtrans
- **Frontend:** Flutter (SDK ^3.8.1) — Android, iOS, Web, Windows
- **Admin UI:** Blade + Vite + Tailwind CSS (inside `mindspace_api`)

## Features

- **Clients:** Registration, therapist search & profiles, appointment booking, secure chat (text + files), session history, reviews, activity history
- **Therapists (Psikolog):** Availability, appointment management, client notes, approval/rejection of bookings
- **Admins:** Dashboard stats, therapist applications (approve/reject), user/therapist suspension, reports (user & conversation), suspension appeals
- **Real-time:** Chat and notifications via Laravel Reverb (Pusher-compatible)

## Prerequisites

- **API:** PHP 8.2+, Composer, Node.js (for Vite), SQLite (or MySQL/PostgreSQL)
- **App:** Flutter SDK ^3.8.1

## Getting started

### 1. Backend (API)

```bash
cd App/mindspace_api
cp .env.example .env
php artisan key:generate
# Edit .env: DB_*, APP_URL, BROADCAST_CONNECTION=reverb, REVERB_*, MIDTRANS_* (if using payments)
composer install
php artisan migrate
php artisan storage:link
```

**Optional (real-time):** Set in `.env`:

- `BROADCAST_CONNECTION=reverb`
- `REVERB_APP_ID`, `REVERB_APP_KEY`, `REVERB_APP_SECRET`, `REVERB_HOST`, `REVERB_PORT`, `REVERB_SCHEME`

Run API + queue + Reverb + Vite (single command):

```bash
composer run dev
```

Or run separately:

```bash
php artisan serve
php artisan queue:listen
php artisan reverb:start   # if using Reverb
npm run dev                # for admin assets
```

### 2. Flutter app

```bash
cd App/mindspace_app
flutter pub get
```

Point the app at your API by editing `lib/config.dart`:

- `backendBaseUrl` — API base URL (e.g. `http://localhost:8000` or `https://api.mindspace.asia`)
- `webSocketHost`, `reverbHost`, `reverbPort`, `reverbScheme`, `webSocketPusherAppKey` — must match your Reverb config in the API `.env`

Run:

```bash
flutter run
# Or: flutter run -d chrome | flutter run -d windows
```

### 3. Admin panel

Admin UI is served by the Laravel app. After `php artisan serve` and `npm run dev`, open the web routes defined in `App/mindspace_api/routes/web.php` (e.g. `/admin` if configured).

## License

This project is licensed under the **CC BY-NC-SA 4.0 License**. See the `LICENSE` file for details.

For commercial use, please contact [hulukootak@gmail.com](mailto:hulukootak@gmail.com) to obtain a separate license.
