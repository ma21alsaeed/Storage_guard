<?php

namespace App\Http\Resources\Operations;

use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Resources\Products\ProductResources;
use Illuminate\Http\Resources\Json\JsonResource;

class OperationSummaryResources extends JsonResource
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
            'id'             => $this->id,
            'type'           => $this->type,
            'name'           => $this->name,
            'user_id'        => $this->user_id,
            'created_at'     => $this->created_at,
            'updated_at'     => $this->updated_at,
            'finished_at'    => $this->finished_at ? Carbon::parse($this->finished_at) : null,
            // 'avg_temp'       => '',
            // 'avg_humidity'   => '',
            // 'last_temp'      => '',
            // 'last_humidity'  => '',
            // 'safety_status'  => '',
            'products_count' => ProductResources::collection($this->products)->count(),
            'readings_count' => SensorReadingsResources::collection($this->sensorReadings)->count()
        ];
    }
}
