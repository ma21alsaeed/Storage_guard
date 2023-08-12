<?php

namespace App\Http\Resources\Products;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ClonedProductLogResources extends JsonResource
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
            'product_id' => $this->product_id,
            'product'    => $this->new_product,
            'created_at' => $this->created_at,
        ];
    }
}
