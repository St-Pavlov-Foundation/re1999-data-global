module("modules.logic.room.entity.actcomp.RoomGiftActComp", package.seeall)

slot0 = class("RoomGiftActComp", LuaCompBase)
slot1 = 0.6

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._materialRes = RoomCharacterEnum.MaterialPath
end

function slot0.addEventListeners(slot0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, slot0._checkActivity, slot0)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, slot0._checkActivity, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, slot0._checkActivity, slot0)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, slot0._checkActivity, slot0)
end

function slot0.onStart(slot0)
	slot0:_checkActivity()
end

function slot0._checkActivity(slot0)
	if slot0:_isShowSpine() then
		if not slot0._isCurShow then
			slot0._isCurShow = true

			slot0:_loadActivitySpine()
		end
	else
		slot0._isCurShow = false

		slot0:destroyAllActivitySpine()
	end
end

function slot0._isShowSpine(slot0)
	if slot0.__willDestroy then
		return false
	end

	return RoomGiftModel.instance:isActOnLine() and RoomGiftModel.instance:isCanGetBonus()
end

function slot0._loadActivitySpine(slot0)
	if slot0._isLoaderDone then
		slot0:_onLoadFinish()

		return
	end

	slot0._loader = slot0._loader or SequenceAbLoader.New()
	slot1 = {}
	slot0.roomGiftSpineList = RoomGiftConfig.instance:getAllRoomGiftSpineList()

	for slot5, slot6 in pairs(slot0.roomGiftSpineList) do
		if not slot1[RoomGiftConfig.instance:getRoomGiftSpineRes(slot6)] then
			slot0._loader:addPath(slot7)

			slot1[slot7] = true
		end
	end

	slot0._loader:addPath(slot0._materialRes)
	slot0._loader:setLoadFailCallback(slot0._onLoadOneFail)
	slot0._loader:startLoad(slot0._onLoadFinish, slot0)
end

function slot0._onLoadOneFail(slot0, slot1, slot2)
	logError("RoomGiftActComp: 加载失败, url: " .. slot2.ResPath)
end

function slot0._onLoadFinish(slot0, slot1)
	if not slot0:_isShowSpine() then
		slot0:destroyAllActivitySpine()

		return
	end

	slot0._isLoaderDone = true

	if not slot0.roomGiftSpineList then
		return
	end

	slot0._activitySpineDict = slot0._activitySpineDict or {}

	for slot5, slot6 in ipairs(slot0.roomGiftSpineList) do
		if gohelper.isNil(slot0._activitySpineDict[slot6] and slot7.spineGO) then
			slot0:destroyActivitySpine(slot7)

			slot7 = {}
			slot9 = RoomGiftConfig.instance:getRoomGiftSpineRes(slot6)
			slot10 = slot0._loader and slot0._loader:getAssetItem(slot9)

			if slot10 and slot10:GetResource(slot9) then
				slot8 = gohelper.clone(slot11, slot0.entity.staticContainerGO, slot6)
				slot12 = RoomGiftConfig.instance:getRoomGiftSpineStartPos(slot6)

				transformhelper.setLocalPos(slot8.transform, slot12[1], slot12[2], slot12[3])

				slot13 = RoomGiftConfig.instance:getRoomGiftSpineScale(slot6)

				transformhelper.setLocalScale(slot8.transform, slot13, slot13, slot13)

				slot15 = slot8:GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial
				slot18 = UnityEngine.GameObject.Instantiate(slot1:getAssetItem(slot0._materialRes):GetResource(slot0._materialRes))

				slot18:SetTexture("_MainTex", slot15:GetTexture("_MainTex"))
				slot18:SetTexture("_BackLight", slot15:GetTexture("_NormalMap"))
				slot18:SetTexture("_DissolveTex", slot15:GetTexture("_DissolveTex"))

				if slot8:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).CustomMaterialOverride then
					slot20:Clear()
					slot20:Add(slot15, slot18)
				end

				slot14.material = slot18
				slot7.spineGO = slot8
				slot7.material = slot18
				slot7.meshRenderer = slot14
				slot7.skeletonAnim = slot19

				gohelper.setLayer(slot8, LayerMask.NameToLayer("Scene"), true)
			end

			slot0._activitySpineDict[slot6] = slot7
		end
	end

	slot0._curSpineAnimIndex = 0

	slot0:delayPlaySpineAnim()
end

function slot0.delayPlaySpineAnim(slot0)
	if not slot0.roomGiftSpineList or not slot0._activitySpineDict then
		return
	end

	slot0._curSpineAnimIndex = slot0._curSpineAnimIndex + 1
	slot2 = slot0.roomGiftSpineList[slot0._curSpineAnimIndex] and slot0._activitySpineDict[slot1]

	if not (slot2 and slot2.skeletonAnim) then
		slot0._curSpineAnimIndex = 0

		return
	end

	slot4 = RoomGiftConfig.instance:getRoomGiftSpineAnim(slot1)

	if slot3 and not string.nilorempty(slot4) then
		slot3:PlayAnim(slot4, true, true)
	end

	TaskDispatcher.cancelTask(slot0.delayPlaySpineAnim, slot0)
	TaskDispatcher.runDelay(slot0.delayPlaySpineAnim, slot0, uv0)
end

function slot0.destroyAllActivitySpine(slot0)
	if slot0._activitySpineDict then
		for slot4, slot5 in pairs(slot0._activitySpineDict) do
			slot0:destroyActivitySpine(slot5)
		end

		slot0._activitySpineDict = nil
	end

	TaskDispatcher.cancelTask(slot0.delayPlaySpineAnim, slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0.roomGiftSpineList = nil
	slot0._isLoaderDone = false
	slot0._isCurShow = false
end

function slot0.destroyActivitySpine(slot0, slot1)
	if not slot1 then
		return
	end

	slot1.meshRenderer = nil
	slot1.skeletonAnim = nil

	if slot1.material then
		gohelper.destroy(slot1.material)

		slot1.material = nil
	end

	gohelper.destroy(slot1.spineGO)
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	slot0:destroyAllActivitySpine()
	slot0:removeEventListeners()
end

function slot0.onDestroy(slot0)
	slot0:destroyAllActivitySpine()
end

return slot0
