<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Response;

class ImageController extends Controller
{
    /**
     * Fetch and return a file from storage.
     */
    public function show($path)
    {
        $imagePath = substr($path, strlen('storage/'));

        if (!Storage::disk('public')->exists($imagePath)) {
            abort(404, 'Image not found on public disk.');
        }

        $file = Storage::disk('public')->get($imagePath);
        $fullPath = Storage::disk('public')->path($imagePath);
        $type = mime_content_type($fullPath) ?: 'application/octet-stream';

        $response = Response::make($file, 200);
        $response->header("Content-Type", $type);

        return $response;
    }
}