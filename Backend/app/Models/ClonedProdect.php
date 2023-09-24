<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClonedProdect extends Model
{
    use HasFactory;
    protected $table = 'cloned_products';
    protected $fillable = [
    'user_id',
    'product_id',
    'new_product'
    ];
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
}
