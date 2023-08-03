<?php

namespace App\Http\Controllers\Api\Products;

use Carbon\Carbon;
use App\Models\Product;
use App\Http\Controllers\Controller;
use App\Http\Resources\Products\ProductResources;
use App\Http\Requests\Products\StoreProductRequest;
use App\Http\Requests\Products\UpdateProductRequest;
use App\Http\Resources\Operations\OperationResources;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return response()->json([
            'data' => ProductResources::collection(Product::all())
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreProductRequest $request)
    {

        $productData = $request->validated();
        $productData['production_date'] = Carbon::parse($productData['production_date']);
        $productData['expity_date'] = Carbon::parse($productData['expity_date']);
        $productData['safety_status'] = 1;
        $product = Product::create($productData);
        return response()->json(
            [
                'message' => 'The product has been successfully added to the store',
                'product' => new ProductResources($product)
            ]);
    }

    /**
     * Display the specified resource.
     */
    public function show($productId)
    {
        try
        {
            $product = Product::findOrFail($productId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'Product not found'], 404);
        }

        return response()->json([
            'product'    => new ProductResources($product),
            'operations' => OperationResources::collection($product->operations)
            ]);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateProductRequest $request, $productId)
    {
        try
        {
            $product = Product::findOrFail($productId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'Product not found'], 404);
        }

        $requestData = $request->validated();
        if ($request->has('production_date'))
        {
            $requestData['production_date'] = Carbon::parse($requestData['production_date']);
        }

        if ($request->has('expiry_date'))
        {
            $requestData['expiry_date'] = Carbon::parse($requestData['expiry_date']);
        }

        $product->fill($requestData);
        $product->save();

        return response()->json([
            'message' => 'The product has been successfully updated in the store',
            'product' => new ProductResources($product)
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($productId)
    {
        try
        {
            $product = Product::findOrFail($productId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'Product not found'], 404);
        }
        $product->delete();
        return response()->json(['message' => 'The product has been deleted successfully.']);
    }
}
