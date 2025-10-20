<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mind Space Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('css/admin.css') }}">
</head>
<body>
    {{-- Navbar --}}
    <nav class="navbar navbar-dark navbar-expand-lg fixed-top shadow-sm" style="background-color: #1E56A0;">
        <div class="container-fluid px-4">
            <a class="navbar-brand fw-semibold text-white" href="#">Mind Space Admin</a>
            <div class="d-flex align-items-center ms-auto">
                <span class="text-white me-3">Admin Dashboard</span>
                <button class="btn btn-light btn-sm">Keluar</button>
            </div>
        </div>
    </nav>

    <div class="d-flex">
        {{-- Sidebar --}}
        <div class="sidebar">
          <a href="{{ url('/admin/dashboard') }}" 
            class="nav-link {{ request()->is('admin/dashboard') ? 'active' : '' }}">
            Dashboard Utama
          </a>

          <a href="{{ url('/admin/psikolog') }}" 
            class="nav-link {{ request()->is('admin/psikolog*') ? 'active' : '' }}">
            Kelola Psikolog
          </a>

          <a href="{{ url('/admin/laporan') }}" 
            class="nav-link {{ request()->is('admin/laporan*') ? 'active' : '' }}">
            Laporan
          </a>
        </div>


        {{-- Konten utama | dashboard.blade.php | laporan.blade.php | psikolog.blade.php --}}
        <main class="main-content">
            @yield('content')
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
