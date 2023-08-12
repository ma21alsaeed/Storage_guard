<?php

namespace App\Http\Resources\Products;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SpoiltProductResources extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'product_id'   => $this->id,
            'operation_id' => $this->operations->last()->id,
            'user_id'      => $this->operations->last()->user_id,
        ];
    }
}
