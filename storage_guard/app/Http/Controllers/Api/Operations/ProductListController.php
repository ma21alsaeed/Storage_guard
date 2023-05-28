<?php

namespace App\Http\Controllers\Api\Operations;

use App\Models\Operation;
use App\Models\ProductsList;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\Products\ProductResources;


class ProductListController extends Controller
{
    /**
     * Display the all products in that operations.
     */
    public function index(Operation $operation)
    {
        return response()->json([
            'data' => ProductResources::collection($operation->products)
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request, Operation $operation)
    {
        $requestData = $request->validate(['product_id' => 'required|numeric|exists:products,id']);
        if ($operation->user_id !== auth()->user()->id)
        {
            return response()->json(['message' => 'Unauthorized.'], 403);
        }
        if (ProductsList::where([['operation_id', '=', $operation->id], ['product_id', '=', $requestData['product_id']]])->count())
        {
            return response()->json(['message' => 'The product is already exist in PoductList.', 'data' => ProductResources::collection($operation->products)]);
        }
        $productList = new ProductsList();
        $productList->operation_id = $operation->id;
        $productList->product_id = (int) $requestData['product_id'];
        $productList->save();
        return response()->json(['message' => 'The product is added successfully.', 'data' => ProductResources::collection($operation->products)]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, Operation $operation)
    {
        $request->validate(['product_id' => 'required']);
        if ($operation->user_id !== auth()->user()->id)
        {
            return response()->json(['message' => 'Unauthorized.'], 403);
        }

        $productList = ProductsList::where([['operation_id', '=', $operation->id], ['product_id', '=', $request->input('product_id')]]);
        if ($productList->count())
        {
            $productList = $productList->first();
            $productList->delete();
            return response()->json(
                [
                    'message' => 'The product has been removed from that operation.',
                    'data'    => ProductResources::collection($operation->products)
                ]);
        }
        return response()->json(['message' => 'Product not found in ProductList.'], 404);
    }
}
