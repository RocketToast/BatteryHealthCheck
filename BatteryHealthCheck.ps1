    $BatteryStatic = Get-CimInstance -Namespace root/wmi -ClassName BatteryStaticData -Property 'DeviceName','DesignedCapacity'
    $BatteryFull   = Get-CimInstance -Namespace root/WMI -ClassName BatteryFullChargedCapacity
    $BatteryCycle  = Get-CimInstance -Namespace root/wmi -ClassName BatteryCycleCount

    $Battery = ( $BatteryFull.FullChargedCapacity / $BatteryStatic.DesignedCapacity ) * 100 -as [int]
            $color = switch ( $Battery ) {
                { $_ -gt 100     } { "DarkGreen" }
                { $_ -in 61..100 } { "Green" }
                { $_ -in 31..60  } { "Yellow" }
                { $_ -in 0..30   } { "Red" }
                Default            { "DarkRed" }
            } # End Switch

            Write-Host @"
        Battery Name:    $( $BatteryStatic.DeviceName )
        Design Capacity: $( $BatteryStatic.DesignedCapacity )
        Full Capacity:   $( $BatteryFull.FullChargedCapacity )
        Cycle Count:     $( $BatteryCycle.CycleCount )
"@
    Write-Host "`tHealth:          $( $Battery )% "  -BackgroundColor $color
