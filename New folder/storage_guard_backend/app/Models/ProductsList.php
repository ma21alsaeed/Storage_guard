<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductsList extends Model
{
    use HasFactory;
    protected $table = 'products_list';
    protected $fillable = [
    'product_id',
    'operation_id'
    ];

    public function operation()
    {
        return $this->belongsTo(Operation::class);
    }
}
