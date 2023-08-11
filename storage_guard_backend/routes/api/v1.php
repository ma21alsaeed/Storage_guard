<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\Auth\UserController;
use App\Http\Controllers\Api\Auth\LoginController;
use App\Http\Controllers\Api\Products\ProductController;
use App\Http\Controllers\Api\Operations\OperationsController;
use App\Http\Controllers\Api\Operations\ProductListController;
use App\Http\Controllers\Api\Products\ClonedProductController;
use App\Http\Controllers\Api\Operations\SensorReadingsController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::get('/user', [UserController::class, 'index']); //show users
Route::Post('/user', [UserController::class, 'store']); //create new user
Route::Post('/login', LoginController::class);
Route::get('/user-id-operations/{Userid}', [OperationsController::class, 'showAllOperations']);

Route::middleware('auth:sanctum')->group(function ()
{
    Route::Put('/user/{userId}', [UserController::class, 'update']);
    Route::Delete('/user/{userId}', [UserController::class, 'destroy']);
    Route::resource('/products', ProductController::class)->except('create', 'edit');
    Route::resource('/user/operations', OperationsController::class)->except('create', 'edit');
    Route::get('/operation-products/{operation}', [ProductListController::class, 'index']);
    Route::post('/operation-products/{operation}', [ProductListController::class, 'store']);
    Route::delete('/operation-products/{operation}', [ProductListController::class, 'destroy']);
    Route::get('/operation-sensor-records/{operation}', [SensorReadingsController::class, 'index']);
    Route::post('/operation-sensor-records/{operation}', [SensorReadingsController::class, 'store']);
    Route::delete('/operation-sensor-records', [SensorReadingsController::class, 'destroy']);
    Route::post('/create-cloned-product', [ClonedProductController::class, 'create']);
    Route::get('/user-cloned-product/{user}', [ClonedProductController::class, 'show']);
});
