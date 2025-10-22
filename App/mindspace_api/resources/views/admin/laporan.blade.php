@extends('layouts.admin')

@section('content')
<div class="container-fluid px-4 py-4">
    <h4 class="fw-bold mb-4">Laporan &amp; Analytics</h4>

    <div class="row mb-4">
        <!-- Revenue Bulanan -->
        <div class="col-md-6 mb-3">
            <div class="card shadow-sm border-0">
                <div class="card-body text-center">
                    <h6 class="fw-bold">Revenue Bulanan</h6>
                    <h2 class="fw-bold text-success mb-0">Rp 2.1M</h2>
                    <p class="text-muted mb-0">September 2025</p>
                </div>
            </div>
        </div>

        <!-- Total Sesi -->
        <div class="col-md-6 mb-3">
            <div class="card shadow-sm border-0">
                <div class="card-body text-center">
                    <h6 class="fw-bold">Revenue Bulanan</h6>
                    <h3 class="fw-bold mb-0">1,234</h3>
                    <p class="text-muted mb-0">Total sesi</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Riwayat Transaksi -->
    <div class="card shadow-sm border-0">
        <div class="card-body">
            <h6 class="fw-bold mb-3">Riwayat Transaksi</h6>
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID Transaksi</th>
                            <th>Klien</th>
                            <th>Terapis</th>
                            <th>Jumlah</th>
                            <th>Status</th>
                            <th>Tanggal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#TRX001</td>
                            <td>Sarah Wijaya</td>
                            <td>Dr. Rani Sari, M.Psi</td>
                            <td class="text-success fw-semibold">Rp 150.000</td>
                            <td><span class="badge bg-success">Berhasil</span></td>
                            <td>1 Sep 2025</td>
                        </tr>
                        <tr>
                            <td>#TRX002</td>
                            <td>Ahmad Fauzi</td>
                            <td>Ahmad Pratama</td>
                            <td class="text-success fw-semibold">Rp 175.000</td>
                            <td><span class="badge bg-warning text-dark">Pending</span></td>
                            <td>3 Sep 2025</td>
                        </tr>
                        <tr>
                            <td>#TRX003</td>
                            <td>Lisa Marlina</td>
                            <td>Siti Mawar</td>
                            <td class="text-success fw-semibold">Rp 160.000</td>
                            <td><span class="badge bg-success">Berhasil</span></td>
                            <td>5 Sep 2025</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
