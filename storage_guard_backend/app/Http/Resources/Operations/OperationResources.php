<?php

namespace App\Http\Resources\Operations;

use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Resources\Products\ProductResources;
use Illuminate\Http\Resources\Json\JsonResource;

class OperationResources extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return
        [
            'id'              => $this->id,
            'type'            => $this->type,
            'created_at'      => $this->created_at,
            'updated_at'      => $this->updated_at,
            'finished_at'     => $this->finished_at ? Carbon::parse($this->finished_at) : null,
            'user'            => $this->user,
            'products'        => ProductResources::collection($this->products),
            'sensor_readings' => SensorReadingsResources::collection($this->sensorReadings)
        ];
    }
}
