module("modules.logic.scene.fight.preloadwork.FightPreloadRolesTimeline", package.seeall)

local var_0_0 = class("FightPreloadRolesTimeline", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not GameResMgr.IsFromEditorDir then
		arg_1_0._loader = MultiAbLoader.New()

		arg_1_0._loader:addPath(ResUrl.getRolesTimeline())
		arg_1_0._loader:startLoad(arg_1_0._onLoadFinish, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onLoadFinish(arg_2_0, arg_2_1)
	arg_2_0.context.callback(arg_2_0.context.callbackObj, arg_2_1:getFirstAssetItem())
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._loader then
		arg_3_0._loader:dispose()

		arg_3_0._loader = nil
	end
end

return var_0_0
