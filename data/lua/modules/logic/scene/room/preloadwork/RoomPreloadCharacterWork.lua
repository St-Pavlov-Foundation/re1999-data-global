module("modules.logic.scene.room.preloadwork.RoomPreloadCharacterWork", package.seeall)

local var_0_0 = class("RoomPreloadCharacterWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:_getUrlList()

	if var_1_0 and #var_1_0 > 0 then
		arg_1_0._loader = MultiAbLoader.New()

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			arg_1_0._loader:addPath(iter_1_1)
		end

		arg_1_0._loader:setLoadFailCallback(arg_1_0._onPreloadOneFail)
		arg_1_0._loader:startLoad(arg_1_0._onPreloadFinish, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onPreloadFinish(arg_2_0, arg_2_1)
	arg_2_0:onDone(true)
end

function var_0_0._onPreloadOneFail(arg_3_0, arg_3_1, arg_3_2)
	logError("RoomPreloadCharacterWork: 加载失败, url: " .. arg_3_2.ResPath)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()

		arg_4_0._loader = nil
	end
end

function var_0_0._getUrlList(arg_5_0)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return nil
	end

	local var_5_0 = {
		RoomCharacterEnum.MaterialPath
	}
	local var_5_1 = RoomCharacterModel.instance:getList()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		arg_5_0:_addListUrl(var_5_0, RoomResHelper.getCharacterPath(iter_5_1.skinId))
		arg_5_0:_addListUrl(var_5_0, RoomResHelper.getCharacterCameraAnimABPath(iter_5_1.roomCharacterConfig.cameraAnimPath))
		arg_5_0:_addListUrl(var_5_0, RoomResHelper.getCharacterEffectABPath(iter_5_1.roomCharacterConfig.effectPath))
		arg_5_0:_addCharacterEffectUrl(var_5_0, iter_5_1.skinId)
	end

	return var_5_0
end

function var_0_0._addListUrl(arg_6_0, arg_6_1, arg_6_2)
	if not string.nilorempty(arg_6_2) then
		table.insert(arg_6_1, arg_6_2)
	end
end

function var_0_0._addCharacterEffectUrl(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = RoomConfig.instance:getCharacterEffectList(arg_7_2)

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if not RoomCharacterEnum.maskInteractAnim[iter_7_1.animName] then
				arg_7_0:_addListUrl(arg_7_1, RoomResHelper.getCharacterEffectABPath(iter_7_1.effectRes))
			end
		end
	end
end

return var_0_0
