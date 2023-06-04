<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SensorReadings extends Model
{
    use HasFactory;
    protected $table = 'sensor_readings';
    protected $fillable = [
    'operation_id',
    'temperature',
    'humidity',
    'read_at'
    ];

    public function operation()
    {
        return $this->belongsTo(Operation::class, 'operation_id', 'id');
    }
}
