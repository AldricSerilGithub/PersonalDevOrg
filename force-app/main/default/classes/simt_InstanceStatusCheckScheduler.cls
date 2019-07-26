/** 
 * Class Name: ASSET_InstanceStatusCheckScheduler
 * @author: Pepper Manawatao
 * Date: 
 * @description Schedulable
 * 
 */
global class simt_InstanceStatusCheckScheduler implements Schedulable {
    global void execute(SchedulableContext SC) {
        simt_InstanceStatusCheck.checkInstanceStatus();
    }
}