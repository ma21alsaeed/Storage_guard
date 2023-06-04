<?php

namespace App\Models;

use Illuminate\Support\Facades\Log;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model
{
    use HasFactory;
    protected $fillable = [
    'name',
    'description',
    'production_date',
    'expity_date',
    'max_temp',
    'min_temp',
    'max_humidity',
    'min_humidity',
    'safety_status'
    ];

    public function operations()
    {
        return $this->hasManyThrough(Operation::class, ProductsList::class, 'product_id', 'id', 'id', 'operation_id');
    }
}
