<?php

namespace App\Http\Controllers\Api\Products;

use Carbon\Carbon;
use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\Products\ProductResources;
use App\Http\Requests\Products\StoreProductRequest;
use App\Http\Requests\Products\UpdateProductRequest;
use App\Http\Resources\Operations\OperationSummaryResources;

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
    public function show(Product $product)
    {
        return response()->json([
            'product'    => new ProductResources($product),
            'operations' => OperationSummaryResources::collection($product->operations)
        ]);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateProductRequest $request, Product $product)
    {
        $requestData = $request->validated();

        $request->input('production_date')
            ? $requestData['production_date'] = Carbon::parse($requestData['production_date'])
            : null;
        $request->input('expity_date')
            ? $requestData['expity_date'] = Carbon::parse($requestData['expity_date'])
            : null;

        $product->fill($requestData);
        $product->save();
        return response()->json(
            [
                'message' => 'The product has been successfully Updated in the store',
                'product' => new ProductResources($product)
            ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Product $product)
    {
        $product->delete();
        return response()->json(['message' => 'The product has been deleted successfully.']);
    }
}
