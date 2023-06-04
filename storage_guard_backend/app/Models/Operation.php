<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Operation extends Model
{
    use HasFactory;

    protected $fillable = [
    'type',
    'user_id',
    'finish_at',
    'created_at'
    ];

    public function products()
    {
        return $this->hasManyThrough(Product::class, ProductsList::class, 'operation_id', 'id', 'id', 'product_id');

    }
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
    public function sensorReadings()
    {
        return $this->hasMany(SensorReadings::class, 'operation_id', 'id');
    }
}
