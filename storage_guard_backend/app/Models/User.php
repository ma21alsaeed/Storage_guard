<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use SebastianBergmann\Type\VoidType;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
    'name',
    'email',
    'password',
    'phone',
    'company',
    'location'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
    'password',
    'remember_token',
    'rule',
    'email_verified_at'
    ];

    /**
     * The attributes that should be cast.
     * @var array<string, string>
     */
    protected $casts = [
    'email_verified_at' => 'datetime',
    ];

    public function operations()
    {
        return $this->hasMany(Operation::class, 'user_id', 'id');
    }
}
