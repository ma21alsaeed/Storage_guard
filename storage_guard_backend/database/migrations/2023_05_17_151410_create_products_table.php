<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table)
        {
            $table->id();
            $table->string('name');
            $table->longText('description');
            $table->timestamp('production_date');
            $table->timestamp('expiry_date');
            $table->double('max_temp');
            $table->double('min_temp');
            $table->double('max_humidity');
            $table->double('min_humidity');
            $table->boolean('safety_status')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement('SET FOREIGN_KEY_CHECKS = 0');
        Schema::drop('products');
        DB::statement('SET FOREIGN_KEY_CHECKS = 1');
    }
};
