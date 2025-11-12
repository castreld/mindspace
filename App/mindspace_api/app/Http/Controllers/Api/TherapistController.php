<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class TherapistController extends Controller
{
    /**
     * Display a listing of the therapists with filtering and searching.
     */
    public function index(Request $request)
    {
        
        $query = User::query()
            ->where('role', 'psikolog')
            ->has('therapistProfile')
            ->where(function ($q) {
                $q->whereNull('suspended_until')
                  ->orWhere('suspended_until', '<=', now());
            });

        
        $query->with(['therapistProfile'])
              ->withAvg('reviews as reviews_avg_rating', 'rating');


        
        $query->when($request->search, function ($q, $search) {
            $q->where('full_name', 'like', "%{$search}%");
        });

        

        
        $query->when($request->gender, function ($q, $gender) {
            $q->where('gender', $gender);
        });

        
        $query->when($request->min_price, function ($q, $min_price) {
            $q->whereHas('therapistProfile', fn($subQuery) => $subQuery->where('hourly_rate', '>=', $min_price));
        });
        $query->when($request->max_price, function ($q, $max_price) {
            $q->whereHas('therapistProfile', fn($subQuery) => $subQuery->where('hourly_rate', '<=', $max_price));
        });

        
        $query->when($request->specializations, function ($q, $specializations) {
            $specList = explode(',', $specializations);
            $q->whereHas('therapistProfile', function ($subQuery) use ($specList) {
                $subQuery->where(function ($jsonQuery) use ($specList) {
                    foreach ($specList as $spec) {
                        $jsonQuery->orWhereJsonContains('specializations', $spec);
                    }
                });
            });
        });

        
        $query->when($request->min_experience, function ($q, $min_experience) {
            $q->whereHas('therapistProfile', fn($subQuery) => $subQuery->where('experience_years', '>=', $min_experience));
        });

        
        $query->when($request->min_rating, function ($q, $min_rating) {
            $q->having('reviews_avg_rating', '>=', $min_rating);
        });
        
        
        $query->when($request->is_available, function ($q, $is_available) {
            if ($is_available === 'true') {
                $q->whereHas('availabilities');
            } elseif ($is_available === 'false') {
                $q->doesntHave('availabilities');
            }
        });

        
        $therapists = $query->paginate(15);

        return response()->json($therapists);
    }

    public function show(User $user)
    {
        
        if ($user->role !== 'psikolog' || !$user->therapistProfile) {
            return response()->json(['message' => 'Therapist not found.'], 404);
        }
        
        if ($user->suspended_until && $user->suspended_until > now()) {
            return response()->json(['message' => 'Therapist not found.'], 404);
        }

        
        $user->load(
            'therapistProfile', 
            'availabilities',   
            'reviews'           
        );

        
        $averageRating = $user->reviews()->avg('rating');

        
        $user->average_rating = number_format($averageRating ?? 0.0, 1);

        return response()->json($user);
    }
}