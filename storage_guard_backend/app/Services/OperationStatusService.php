<?php

namespace App\Services;

class OperationStatusService
{

    public function getLastTemp($sensorReadings)
    {
        return $sensorReadings->last()->temperature;
    }
    public function getLastHumidity($sensorReadings)
    {
        return $sensorReadings->last()->humidity;
    }
    public function getAvgTemp($sensorReadings)
    {
        $array = [];
        foreach ($sensorReadings as $sensorReading)
        {
            $array[] = $sensorReading->temperature;
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
        return array_sum($array) / count($array);
        ;
    }
    public function getSafetyStatus($products)
    {
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
