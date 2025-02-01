module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessSleepMonsterEffect", package.seeall)

slot0 = class("Va3ChessSleepMonsterEffect", Va3ChessEffectBase)

function slot0.refreshEffect(slot0)
end

function slot0.onDispose(slot0)
end

function slot0.setSleep(slot0, slot1)
	slot0:_setSleepAnim(slot1, true)
end

function slot0._setSleepAnim(slot0, slot1, slot2)
	if slot0.isLoadFinish and slot0._target.avatar then
		slot3 = slot0._target.avatar

		if slot0._lastIsZreo ~= (slot1 <= 0) then
			slot0._lastIsZreo = slot4

			gohelper.setActive(slot3.goNumber, not slot4)
			gohelper.setActive(slot3.goSleepB, not slot4)
			gohelper.setActive(slot3.goSleepA, slot4)
			gohelper.setActive(slot3.goTanhao, slot4)

			if slot2 then
				slot3.animatorSleep:Play(slot4 and "big" or "little")
			end

			if slot2 and slot4 then
				AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_monster_awake)
			end
		end

		if not slot4 then
			slot5 = Mathf.Floor(slot1 / 10) % 10

			if slot1 < 10 then
				slot5 = slot1 % 10
				slot6 = 0
			end

			gohelper.setActive(slot3.meshEffNum2, slot1 >= 10)

			if slot0._lastNum1 ~= slot5 then
				slot0._lastNum1 = slot5

				slot0:_setMeshNum(slot3.meshEffNum1, slot3.numPropertyBlock, slot5)
			end

			if slot0._lastNum2 ~= slot6 then
				slot0._lastNum2 = slot6

				slot0:_setMeshNum(slot3.meshEffNum2, slot3.numPropertyBlock, slot6)
			end
		end

		slot0._target:getHandler():setAlertActive(slot4)
	end
end

function slot0._getOffsetByNum(slot0, slot1)
	if slot1 >= 0 and slot1 <= 9 then
		return slot1 * 0.1
	end

	return 1
end

function slot0._setMeshNum(slot0, slot1, slot2, slot3)
	slot2:Clear()
	slot2:SetVector("_MainTex_ST", Vector4.New(0.1, 1, slot0:_getOffsetByNum(slot3 - 1), 0))
	slot1:SetPropertyBlock(slot2)
end

function slot0.onAvatarLoaded(slot0)
	slot1 = slot0._loader

	if not slot0._loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot3 = slot0._target.avatar
		slot4 = gohelper.findChild(slot2, "vx_tracked")
		slot5 = gohelper.findChild(slot2, "vx_number")
		slot3.meshEffNum1 = gohelper.findChild(slot2, "vx_number/1"):GetComponent(Va3ChessEnum.ComponentType.MeshRenderer)
		slot3.meshEffNum2 = gohelper.findChild(slot2, "vx_number/2"):GetComponent(Va3ChessEnum.ComponentType.MeshRenderer)
		slot3.meshEffNum1.material = UnityEngine.Material.New(slot3.meshEffNum1.material)
		slot3.meshEffNum2.material = UnityEngine.Material.New(slot3.meshEffNum2.material)

		gohelper.setActive(slot3.goTrack, false)
		gohelper.setActive(slot4, false)
		gohelper.setActive(slot5, false)

		slot3.goTrack = slot4
		slot3.goNumber = slot5
		slot3.goTanhao = gohelper.findChild(slot2, "icon_tanhao")
		slot3.numPropertyBlock = UnityEngine.MaterialPropertyBlock.New()
		slot7 = slot3.loader:getInstGO()
		slot3.goSleepA = gohelper.findChild(slot7, "a")
		slot3.goSleepB = gohelper.findChild(slot7, "b")
		slot3.animatorSleep = slot7:GetComponent(Va3ChessEnum.ComponentType.Animator)

		gohelper.setActive(slot3.goSleepA, false)

		if Va3ChessGameModel.instance:getObjectDataById(slot0._target.id) and slot8.data and slot9.attributes and slot9.attributes.sleep then
			slot0:_setSleepAnim(slot9.attributes.sleep)
		end
	end
end

return slot0
