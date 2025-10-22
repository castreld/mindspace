@extends('layouts.admin')

@section('content')
<div class="container-fluid p-4">
    <h4 class="fw-bold mb-1">Kelola Psikolog</h4>
    <p class="text-muted">Daftar Psikolog</p>

    <div class="d-flex justify-content-between align-items-center mb-3">
        <div></div>
        <button class="btn btn-primary">
            + Tambah Psikolog
        </button>
    </div>

    <div class="card shadow-sm border-0 p-4 mb-4">
        <div class="d-flex flex-wrap gap-2 mb-3">
            <input type="text" class="form-control" placeholder="Cari nama terapis atau spesialisasi" style="max-width: 400px;">
            <select class="form-select" style="max-width: 180px;">
                <option>Semua Status</option>
                <option>Aktif</option>
                <option>Pending</option>
                <option>Suspended</option>
            </select>
            <button class="btn btn-outline-primary px-4">Filter</button>
        </div>

        <h5 class="fw-semibold mb-3">Sesi Hari Ini</h5>

        <div class="table-responsive">
            <table class="table align-middle table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Nama</th>
                        <th>Spesialisasi</th>
                        <th>Pengalaman</th>
                        <th>Rating</th>
                        <th>Status</th>
                        <th class="text-center">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="{{ asset('images/psikolog1.jpg') }}" class="rounded-circle me-3" width="40" height="40">
                                <div>
                                    <div class="fw-semibold">Dr. Rani Sari, M.Psi</div>
                                    <small class="text-muted">rani.sari@email.com</small>
                                </div>
                            </div>
                        </td>
                        <td>Stres & Burnout</td>
                        <td>15 Jan 2025</td>
                        <td><i class="bi bi-star-fill text-warning"></i> 4.9 <small class="text-muted">(150 review)</small></td>
                        <td><span class="badge bg-success px-3 py-2">Aktif</span></td>
                        <td class="text-center">
                            <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detailPsikologModal" onclick="showDetailPsikolog('Dr. Rani Sari, M.Psi')">
                                Lihat
                            </button>
                            <button class="btn btn-warning text-white btn-sm px-3">Suspend</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="d-flex align-items-center">
                                <img src="{{ asset('images/psikolog2.jpg') }}" class="rounded-circle me-3" width="40" height="40">
                                <div>
                                    <div class="fw-semibold">Dr. Nabila R., M.Psi</div>
                                    <small class="text-muted">nabila.r@email.com</small>
                                </div>
                            </div>
                        </td>
                        <td>Kecemasan & Self-Esteem</td>
                        <td>7 Tahun</td>
                        <td><i class="bi bi-star text-secondary"></i> 0 <small class="text-muted">(0 review)</small></td>
                        <td><span class="badge bg-warning px-3 py-2 text-dark">Pending</span></td>
                        <td class="text-center">
                            <button class="btn btn-success btn-sm px-3">Terima</button>
                            <button class="btn btn-danger btn-sm px-3">Tolak</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal Detail Psikolog -->
@include('admin.modals.detail_psikolog')

@endsection

@section('scripts')
<script>
function showDetail(nama, spesialisasi, alamat, status, rating, pengalaman, pendidikan, tahun, harga, foto) {
    document.getElementById('detail-nama').innerText = nama;
    document.getElementById('detail-spesialisasi').innerText = spesialisasi;
    document.getElementById('detail-alamat').innerText = alamat;
    document.getElementById('detail-status').innerText = status;
    document.getElementById('detail-rating').innerText = rating;
    document.getElementById('detail-pengalaman').innerText = pengalaman;
    document.getElementById('detail-pendidikan').innerText = pendidikan;
    document.getElementById('detail-tahun').innerText = tahun;
    document.getElementById('detail-harga').innerText = harga;
    document.getElementById('detail-foto').src = foto;
}
</script>
@endsection
