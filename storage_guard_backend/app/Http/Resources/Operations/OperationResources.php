<?php

namespace App\Http\Resources\Operations;

use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Services\OperationStatusService;
use Illuminate\Http\Resources\Json\JsonResource;
use App\Http\Resources\Products\ProductResources;

class OperationResources extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $myService = new OperationStatusService();
        return
        [
            'id'              => $this->id,
            'type'            => $this->type,
            'name'            => $this->name,
            'created_at'      => $this->created_at,
            'updated_at'      => $this->updated_at,
            'finished_at'     => $this->finished_at ? Carbon::parse($this->finished_at) : null,
            'user'            => $this->user,
            'products'        => ProductResources::collection($this->products),
            'sensor_readings' => SensorReadingsResources::collection($this->sensorReadings)
        ];
    }
}
