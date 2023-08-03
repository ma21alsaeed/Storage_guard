<?php

namespace App\Http\Controllers\Api\Products;

use App\Models\User;
use App\Models\Product;
use App\Models\ClonedProdect;
use App\Http\Controllers\Controller;
use App\Http\Resources\Products\ProductResources;
use App\Http\Requests\Products\ClonedProductRequest;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Http\Resources\Products\ClonedProductLogResources;

class ClonedProductController extends Controller
{
    public function create(ClonedProductRequest $request)
    {
        $product = Product::find($request->validated())->first();
        $newProduct = new Product();
        $newProduct->fill($product->toArray());
        // return $product;
        // return $newProduct;
        $newProduct->save();

        $clonedLog = new ClonedProdect();
        $clonedLog->user_id = auth()->user()->id;
        $clonedLog->product_id = $product->id;
        $clonedLog->new_product = $newProduct->id;
        $clonedLog->save();
        return response()->json(
            [
                'message'     => 'The product has been successfully cloned and added to the store.',
                'new_product' => new ProductResources($newProduct)
            ]);
    }
    public function show($userId)
    {
        try
        {
            $user = User::findOrFail($userId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'User not found'], 404);
        }

        // $clonedLog = ClonedProdect::where('user_id', auth()->user()->id);
        // return $clonedLog;
        // return $user->clonedProducts;
        return response()->json([
            'cloned_Products' => ClonedProductLogResources::collection($user->clonedProducts)
        ]);
    }
}
