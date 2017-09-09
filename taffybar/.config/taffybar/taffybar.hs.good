import System.Taffybar
import System.Taffybar.Systray
import System.Taffybar.TaffyPager
import System.Taffybar.Battery
import System.Taffybar.SimpleClock
import System.Taffybar.DiskIOMonitor
import System.Taffybar.Widgets.PollingGraph
import System.Taffybar.Widgets.PollingBar
import System.Information.CPU
import System.Information.Memory
import System.Information.Battery
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.MPRIS2

main = do
    let mem = pollingGraphNew memCfg 1 memCallback
            where
                memCallback = do
                    mi <- parseMeminfo
                    return [memoryUsedRatio mi]
                memCfg = defaultGraphConfig
                    { graphDataColors = [(1, 0, 0, 1)]
                    , graphLabel = Nothing
                    , graphDirection = RIGHT_TO_LEFT
                    }

        cpu = pollingGraphNew cpuCfg 1 cpuCallback
            where
                cpuCallback = do
                    (_, _, totalLoad) <- cpuLoad
                    return [totalLoad]
                cpuCfg = defaultGraphConfig
                    { graphDataColors = [(0, 1, 0, 1)]
                    , graphLabel = Nothing
                    , graphDirection = RIGHT_TO_LEFT
                    }

        disk = dioMonitorNew dskCfg 1 "sda"
           where
               dskCfg = defaultGraphConfig 
                   { graphDataColors = [(0.5, 0.63, 0.74, 1)]
                    , graphLabel = Nothing
                    , graphDirection = RIGHT_TO_LEFT
                   }


        note = notifyAreaNew defaultNotificationConfig
        mpris = mpris2New
        clock = textClockNew Nothing "<span fgcolor='#81a2be'>%a %b %_d %H:%M</span>" 1
        log = taffyPagerNew defaultPagerConfig
        tray = systrayNew
        battery = textBatteryNew "$percentage$%/$time$" 60

    defaultTaffybar defaultTaffybarConfig { 
        barHeight = 20
        , startWidgets = [ log, note ]
        , endWidgets = [mpris, tray, battery, clock, disk, mem, cpu ]
        }
