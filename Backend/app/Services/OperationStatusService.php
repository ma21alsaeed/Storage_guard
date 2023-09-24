<?php

namespace App\Services;

class OperationStatusService
{

    public function getLastTemp($sensorReadings)
    {
        if ($sensorReadings->count())
        {
            return $sensorReadings->last()->temperature;
        }
        return null;

    }
    public function getLastHumidity($sensorReadings)
    {
        if ($sensorReadings->count())
        {
            return $sensorReadings->last()->humidity;
        }
        return null;

    }
    public function getAvgTemp($sensorReadings)
    {
        $array = [];
        foreach ($sensorReadings as $sensorReading)
        {
            $array[] = $sensorReading->temperature;
        }
        if (!$array)
        {
            return null;
        }
        return array_sum($array) / count($array);
        ;
    }
    public function getAvgHumidity($sensorReadings)
    {

        $array = [];
        foreach ($sensorReadings as $sensorReading)
        {
            $array[] = $sensorReading->humidity;
        }
        if (!$array)
        {
            return null;
        }
        return array_sum($array) / count($array);
        ;
    }
    public function getSafetyStatus($products)
    {
        if (!$products)
        {
            return null;
        }
        foreach ($products as $product)
        {
            if (!$product->safety_status)
            {
                return 0;
            }
        }
        return 1;
    }
}
