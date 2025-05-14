module("modules.logic.scene.cachot.comp.CachotSceneViewComp", package.seeall)

local var_0_0 = class("CachotSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	if not V1a6_CachotModel.instance:isInRogue() then
		ViewMgr.instance:openView(ViewName.V1a6_CachotMainView)

		if V1a6_CachotModel.instance:getRogueEndingInfo() then
			V1a6_CachotController.instance:openV1a6_CachotFinishView()
		end
	else
		ViewMgr.instance:openView(ViewName.V1a6_CachotRoomView)

		local var_1_0 = V1a6_CachotRoomModel.instance:getNowTopEventMo()

		if var_1_0 then
			local var_1_1 = lua_rogue_event.configDict[var_1_0.eventId]

			if not var_1_1 or var_1_1.type == V1a6_CachotEnum.EventType.Battle and not var_1_0:isBattleSuccess() then
				return
			end

			local var_1_2 = V1a6_CachotModel.instance:getRogueInfo()

			for iter_1_0, iter_1_1 in ipairs(var_1_2.selectedEvents) do
				V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, iter_1_1)
			end
		end
	end
end

function var_0_0.getRoot(arg_2_0)
	return arg_2_0._uiRoot
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._uiRoot, arg_3_1)
end

function var_0_0.onSceneClose(arg_4_0, arg_4_1, arg_4_2)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotRoomView)
end

return var_0_0
