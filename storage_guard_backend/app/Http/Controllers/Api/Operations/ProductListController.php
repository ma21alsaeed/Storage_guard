<?php

namespace App\Http\Controllers\Api\Operations;

use App\Models\Operation;
use App\Models\ProductsList;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Resources\Products\ProductResources;


class ProductListController extends Controller
{
    /**
     * Display the all products in that operations.
     */
    public function index($operaionId)
    {
        try
        {
            $operation = Operation::findOrFail($operaionId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'Operation not found.'], 404);
        }
        return response()->json([
            'products' => ProductResources::collection($operation->products)
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request, $operationId)
    {
        $operation = Operation::where('id', $operationId)
                                ->where('user_id', auth()->user()->id)
                                ->first();

        if (!$operation)
        {
            return response()->json(['message' => 'Operation not found.'], 404);
        }

        $requestData = $request->validate([
            'product_id' => 'required|numeric|exists:products,id'
        ]);
        $productList = ProductsList::where('operation_id', $operation->id)
                                    ->where('product_id', $requestData['product_id'])
                                    ->first();

        if ($productList)
        {
            return response()->json([
                'message' => 'The product is already exist in PoductList.',
                'data'    => ProductResources::collection($operation->products)
            ]);
        }
        $productList = new ProductsList();
        $productList->operation_id = $operation->id;
        $productList->product_id = (int) $requestData['product_id'];
        $productList->save();
        return response()->json([
            'message' => 'The product is added successfully.',
            'data'    => ProductResources::collection($operation->products)
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, $operationId)
    {
        $operation = Operation::where('id', $operationId)->where('user_id', auth()->user()->id)->first();

        if (!$operation)
        {
            return response()->json(['message' => 'Operation not found.'], 404);
        }

        $request->validate(['product_id' => 'required']);

        $productList = ProductsList::where('operation_id', $operation->id)
                                    ->where('product_id', $request->input('product_id'))
                                    ->first();

        if ($productList)
        {
            $productList->delete();
            return response()->json([
                'message' => 'The product has been removed from that operation.',
                'data'    => ProductResources::collection($operation->products)
            ]);
        }

        return response()->json(['message' => 'Product not found in ProductList.'], 404);
    }
}
