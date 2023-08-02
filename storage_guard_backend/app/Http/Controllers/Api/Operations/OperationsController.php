<?php

namespace App\Http\Controllers\Api\Operations;

use App\Services\OperationStatusService;
use Carbon\Carbon;
use App\Models\Operation;
use App\Models\ProductsList;
use App\Http\Controllers\Controller;
use App\Http\Resources\Operations\OperationResources;
use App\Http\Requests\Operations\StoreOperationRequest;
use App\Http\Requests\Operations\UpdateOperationRequest;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Http\Resources\Operations\OperationSummaryResources;

class OperationsController extends Controller
{
    /**
     * Display a listing of the operations that belong to auth user.
     */
    public function index()
    {
        return response()->json(['data' => OperationSummaryResources::collection(auth()->user()->operations)]);
    }

    /**
     * Store a newly created operation in storage for auth user.
     */
    public function store(StoreOperationRequest $request)
    {
        $incomingData = $request->validated();
        /**
         * create operation record
         */
        $operation = Operation::create(
            [
                'type'    => $incomingData['type'],
                'name'    => $incomingData['name'],
                'user_id' => auth()->user()->id
            ]);
        /**
         * create porductList records
         */
        foreach ($incomingData['products'] as $item)
        {
            if (ProductsList::where('operation_id', '=', $operation->id)->where('product_id', '=', $item['id'])->count())
                continue;

            $productList = new ProductsList();
            $productList->operation_id = $operation->id;
            $productList->product_id = (int) $item['id'];
            $productList->save();
        }

        return response()->json([
            'message' => 'The operation has been created successfully.',
            'data'    => new OperationResources($operation)
        ]);

    }

    /**
     * Display the specified resource.
     */
    public function show($operationId)
    {
        try
        {
            $operation = Operation::findOrFail($operationId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'Operation not found.'], 404);
        }
        return response()->json(['data' => new OperationResources($operation)]);
    }

    /**
     * Update the specified operation that belong to user in storage.
     */
    public function update(UpdateOperationRequest $request, $operationId)
    {

        $operation = Operation::where('id', $operationId)->where('user_id', auth()->user()->id)->first();

        if (!$operation)
        {
            return response()->json(['message' => 'Operation not found.'], 404);
        }

        if (!$request->validated())
        {
            return response()->json(['message' => 'Please provide information to update.'], 400);
        }

        $requestData = $request->validated();
        if (isset($requestData['created_at']))
        {
            $operation['created_at'] = Carbon::parse($requestData['created_at']);
        }
        if (isset($requestData['finished_at']))
        {
            $operation['finished_at'] = Carbon::parse($requestData['finished_at']);
        }
        if (isset($requestData['type']))
        {
            $operation['type'] = $requestData['type'];
        }
        if (isset($requestData['name']))
        {
            $operation['name'] = $requestData['name'];
        }
        $operation->save();
        return response()->json(
            [
                'message'   => 'Operation updated successfully.',
                'operation' => new OperationResources($operation)
            ]);
    }
    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Operation $operation)
    {

        if ($operation->user_id !== auth()->user()->id)
        {
            return response()->json(['message' => 'Unauthorized.'], 403);
        }
        $operation->delete();
        return response()->json(['message' => 'Your operation has been deleted successfully.']);
    }
}
