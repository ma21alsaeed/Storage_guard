<?php

namespace App\Http\Requests\Products;

use Illuminate\Foundation\Http\FormRequest;

class StoreProductRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'name'            => 'required|string',
            'description'     => 'required|string',
            'production_date' => 'required|date',
            'expiry_date'     => 'required|date|after:production_date',
            'max_temp'        => 'required|numeric',
            'min_temp'        => 'required|numeric',
            'max_humidity'    => 'required|numeric',
            'min_humidity'    => 'required|numeric',
        ];
    }
}
