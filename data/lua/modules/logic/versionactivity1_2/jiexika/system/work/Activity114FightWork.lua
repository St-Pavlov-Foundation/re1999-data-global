module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114FightWork", package.seeall)

local var_0_0 = class("Activity114FightWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, arg_1_0.context.eventId)

	ViewMgr.instance:closeView(ViewName.Activity114EmptyView, true, true)
	Activity114Controller.instance:enterActivityFight(var_1_0.config.battleId)
	arg_1_0:onDone(true)
end

return var_0_0
