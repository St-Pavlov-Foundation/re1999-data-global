module("modules.logic.room.entity.actcomp.RoomGiftActComp", package.seeall)

local var_0_0 = class("RoomGiftActComp", LuaCompBase)
local var_0_1 = 0.6

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._materialRes = RoomCharacterEnum.MaterialPath
end

function var_0_0.addEventListeners(arg_3_0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, arg_3_0._checkActivity, arg_3_0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, arg_3_0._checkActivity, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, arg_4_0._checkActivity, arg_4_0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, arg_4_0._checkActivity, arg_4_0)
end

function var_0_0.onStart(arg_5_0)
	arg_5_0:_checkActivity()
end

function var_0_0._checkActivity(arg_6_0)
	if arg_6_0:_isShowSpine() then
		if not arg_6_0._isCurShow then
			arg_6_0._isCurShow = true

			arg_6_0:_loadActivitySpine()
		end
	else
		arg_6_0._isCurShow = false

		arg_6_0:destroyAllActivitySpine()
	end
end

function var_0_0._isShowSpine(arg_7_0)
	if arg_7_0.__willDestroy then
		return false
	end

	local var_7_0 = RoomGiftModel.instance:isActOnLine()
	local var_7_1 = RoomGiftModel.instance:isCanGetBonus()

	return var_7_0 and var_7_1
end

function var_0_0._loadActivitySpine(arg_8_0)
	if arg_8_0._isLoaderDone then
		arg_8_0:_onLoadFinish()

		return
	end

	arg_8_0._loader = arg_8_0._loader or SequenceAbLoader.New()

	local var_8_0 = {}

	arg_8_0.roomGiftSpineList = RoomGiftConfig.instance:getAllRoomGiftSpineList()

	for iter_8_0, iter_8_1 in pairs(arg_8_0.roomGiftSpineList) do
		local var_8_1 = RoomGiftConfig.instance:getRoomGiftSpineRes(iter_8_1)

		if not var_8_0[var_8_1] then
			arg_8_0._loader:addPath(var_8_1)

			var_8_0[var_8_1] = true
		end
	end

	arg_8_0._loader:addPath(arg_8_0._materialRes)
	arg_8_0._loader:setLoadFailCallback(arg_8_0._onLoadOneFail)
	arg_8_0._loader:startLoad(arg_8_0._onLoadFinish, arg_8_0)
end

function var_0_0._onLoadOneFail(arg_9_0, arg_9_1, arg_9_2)
	logError("RoomGiftActComp: 加载失败, url: " .. arg_9_2.ResPath)
end

function var_0_0._onLoadFinish(arg_10_0, arg_10_1)
	if not arg_10_0:_isShowSpine() then
		arg_10_0:destroyAllActivitySpine()

		return
	end

	arg_10_0._isLoaderDone = true

	if not arg_10_0.roomGiftSpineList then
		return
	end

	arg_10_0._activitySpineDict = arg_10_0._activitySpineDict or {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.roomGiftSpineList) do
		local var_10_0 = arg_10_0._activitySpineDict[iter_10_1]
		local var_10_1 = var_10_0 and var_10_0.spineGO

		if gohelper.isNil(var_10_1) then
			arg_10_0:destroyActivitySpine(var_10_0)

			local var_10_2 = {}
			local var_10_3 = RoomGiftConfig.instance:getRoomGiftSpineRes(iter_10_1)
			local var_10_4 = arg_10_0._loader and arg_10_0._loader:getAssetItem(var_10_3)
			local var_10_5 = var_10_4 and var_10_4:GetResource(var_10_3)

			if var_10_5 then
				local var_10_6 = gohelper.clone(var_10_5, arg_10_0.entity.staticContainerGO, iter_10_1)
				local var_10_7 = RoomGiftConfig.instance:getRoomGiftSpineStartPos(iter_10_1)

				transformhelper.setLocalPos(var_10_6.transform, var_10_7[1], var_10_7[2], var_10_7[3])

				local var_10_8 = RoomGiftConfig.instance:getRoomGiftSpineScale(iter_10_1)

				transformhelper.setLocalScale(var_10_6.transform, var_10_8, var_10_8, var_10_8)

				local var_10_9 = var_10_6:GetComponent(typeof(UnityEngine.MeshRenderer))
				local var_10_10 = var_10_9.sharedMaterial
				local var_10_11 = arg_10_1:getAssetItem(arg_10_0._materialRes):GetResource(arg_10_0._materialRes)
				local var_10_12 = UnityEngine.GameObject.Instantiate(var_10_11)

				var_10_12:SetTexture("_MainTex", var_10_10:GetTexture("_MainTex"))
				var_10_12:SetTexture("_BackLight", var_10_10:GetTexture("_NormalMap"))
				var_10_12:SetTexture("_DissolveTex", var_10_10:GetTexture("_DissolveTex"))

				local var_10_13 = var_10_6:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
				local var_10_14 = var_10_13.CustomMaterialOverride

				if var_10_14 then
					var_10_14:Clear()
					var_10_14:Add(var_10_10, var_10_12)
				end

				var_10_9.material = var_10_12
				var_10_2.spineGO = var_10_6
				var_10_2.material = var_10_12
				var_10_2.meshRenderer = var_10_9
				var_10_2.skeletonAnim = var_10_13

				gohelper.setLayer(var_10_6, LayerMask.NameToLayer("Scene"), true)
			end

			arg_10_0._activitySpineDict[iter_10_1] = var_10_2
		end
	end

	arg_10_0._curSpineAnimIndex = 0

	arg_10_0:delayPlaySpineAnim()
end

function var_0_0.delayPlaySpineAnim(arg_11_0)
	if not arg_11_0.roomGiftSpineList or not arg_11_0._activitySpineDict then
		return
	end

	arg_11_0._curSpineAnimIndex = arg_11_0._curSpineAnimIndex + 1

	local var_11_0 = arg_11_0.roomGiftSpineList[arg_11_0._curSpineAnimIndex]
	local var_11_1 = var_11_0 and arg_11_0._activitySpineDict[var_11_0]
	local var_11_2 = var_11_1 and var_11_1.skeletonAnim

	if not var_11_2 then
		arg_11_0._curSpineAnimIndex = 0

		return
	end

	local var_11_3 = RoomGiftConfig.instance:getRoomGiftSpineAnim(var_11_0)

	if var_11_2 and not string.nilorempty(var_11_3) then
		var_11_2:PlayAnim(var_11_3, true, true)
	end

	TaskDispatcher.cancelTask(arg_11_0.delayPlaySpineAnim, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0.delayPlaySpineAnim, arg_11_0, var_0_1)
end

function var_0_0.destroyAllActivitySpine(arg_12_0)
	if arg_12_0._activitySpineDict then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._activitySpineDict) do
			arg_12_0:destroyActivitySpine(iter_12_1)
		end

		arg_12_0._activitySpineDict = nil
	end

	TaskDispatcher.cancelTask(arg_12_0.delayPlaySpineAnim, arg_12_0)

	if arg_12_0._loader then
		arg_12_0._loader:dispose()

		arg_12_0._loader = nil
	end

	arg_12_0.roomGiftSpineList = nil
	arg_12_0._isLoaderDone = false
	arg_12_0._isCurShow = false
end

function var_0_0.destroyActivitySpine(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	arg_13_1.meshRenderer = nil
	arg_13_1.skeletonAnim = nil

	if arg_13_1.material then
		gohelper.destroy(arg_13_1.material)

		arg_13_1.material = nil
	end

	gohelper.destroy(arg_13_1.spineGO)
end

function var_0_0.beforeDestroy(arg_14_0)
	arg_14_0.__willDestroy = true

	arg_14_0:destroyAllActivitySpine()
	arg_14_0:removeEventListeners()
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0:destroyAllActivitySpine()
end

return var_0_0
