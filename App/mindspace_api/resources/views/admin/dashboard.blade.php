@extends('layouts.admin')

@section('content')
<div class="container-fluid">
    <h3 class="fw-bold mb-4">Dashboard Utama</h3>

    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card-dashboard p-3">
                <div class="icon">👥</div>
                <h4 class="fw-semibold">1,247</h4>
                <small class="text-muted">Total Klien Aktif</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-dashboard p-3">
                <div class="icon">🧑‍⚕️</div>
                <h4 class="fw-semibold">89</h4>
                <small class="text-muted">Terapis Terdaftar</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-dashboard p-3">
                <div class="icon">💬</div>
                <h4 class="fw-semibold">3,456</h4>
                <small class="text-muted">Sesi Selesai</small>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card-dashboard p-3">
                <div class="icon">⭐</div>
                <h4 class="fw-semibold">4.8</h4>
                <small class="text-muted">Rating Platform</small>
            </div>
        </div>
    </div>

    {{-- Aktivitas & Perhatian --}}
    <div class="row g-3 mb-4">
        <div class="col-md-6">
            <div class="card p-3">
                <h5 class="fw-bold mb-3">Aktivitas Terbaru</h5>
                <p>Dr. Rani Sari mendaftar <small class="text-muted">2 jam lalu</small></p>
                <p>Pembayaran Rp150.000 diterima <small class="text-muted">3 jam lalu</small></p>
                <p>Sarah W. booking sesi baru <small class="text-muted">4 jam lalu</small></p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card p-3">
                <h5 class="fw-bold mb-3">Perlu Perhatian</h5>
                <div class="alert alert-warning mb-2">12 Pendaftaran Terapis - menunggu verifikasi</div>
                <div class="alert alert-danger mb-2">3 Keluhan dari klien perlu ditangani</div>
                <div class="alert alert-success">Platform berjalan normal - Tidak ada masalah teknis</div>
            </div>
        </div>
    </div>

    {{-- Tabel --}}
    <div class="card p-3">
        <h5 class="fw-bold mb-3">Sesi Hari Ini</h5>
        <table class="table align-middle">
            <thead>
                <tr>
                    <th>Nama</th>
                    <th>Email</th>
                    <th>Bergabung</th>
                    <th>Total Sesi</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Sarah Wijaya</td>
                    <td>sarahlovetherapy@email.com</td>
                    <td>15 Jan 2025</td>
                    <td>12 sesi</td>
                    <td><span class="badge badge-success">Aktif</span></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
@endsection
