module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandWordComp", package.seeall)

slot0 = class("FairyLandWordComp", LuaCompBase)
slot1 = "<size=40><alpha=#00>.<alpha=#ff></size>"

function slot2(slot0)
	slot1 = nil

	if LangSettings.instance:isEn() then
		slot5 = 1

		for slot5 = 1, #{
			string.byte(slot0, slot5, -1)
		} do
			if slot1[slot5] == 32 then
				slot1[slot5] = uv0
			else
				slot1[slot5] = string.char(slot1[slot5])
			end
		end
	else
		slot1 = LuaUtil.getUCharArr(slot0)
	end

	return slot1 or {}
end

slot0.WordInterval = 3.5
slot0.WordTxtPosYOffset = 5
slot0.WordTxtPosXOffset = 2
slot0.WordTxtInterval = 0.1
slot0.WordTxtOpen = 0.5
slot0.WordTxtIdle = 1.1
slot0.WordTxtClose = 0.5
slot0.WordLine2Delay = 1

function slot0.ctor(slot0, slot1)
	slot0._co = slot1.co
	slot0._res1 = slot1.res1
	slot0._res2 = slot1.res2
end

function slot0.init(slot0, slot1)
	slot0.go = slot1

	slot0:createTxt()
end

function slot0.createTxt(slot0)
	slot1 = uv0.WordTxtOpen + uv0.WordTxtIdle + uv0.WordTxtClose
	slot0._allAnimWork = {}
	slot5 = 1

	for slot9 = 1, #uv1(slot0._co.question) do
		slot10, slot11 = slot0:getRes(slot0.go, slot0._res1)
		slot11.text = slot3[slot9]
		slot4 = 0 + slot11.preferredWidth + uv0.WordTxtPosXOffset

		recthelper.setWidth(slot11.transform.parent, slot11.preferredWidth)
		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot10,
			time = (slot5 - 1) * uv0.WordTxtInterval
		})

		slot5 = slot5 + 1
	end

	slot6 = uv1(slot0._co.answer)
	slot6[0] = "——"

	for slot10 = 0, #slot6 do
		slot11, slot12 = slot0:getRes(slot0.go, slot0._res2)
		slot12.text = slot6[slot10]
		slot4 = slot4 + slot12.preferredWidth + uv0.WordTxtPosXOffset

		recthelper.setWidth(slot12.transform.parent, slot12.preferredWidth)
		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot11,
			time = (slot5 - 1) * uv0.WordTxtInterval
		})

		slot5 = slot5 + 1
	end

	slot7 = slot1 + uv0.WordTxtInterval * (#slot3 - 1)
	slot8 = 0

	if #slot6 > 0 then
		slot8 = slot1 + uv0.WordTxtInterval * (#slot6 - 1)
	end

	slot9 = math.max(slot7, slot8)

	table.sort(slot0._allAnimWork, uv0.sortAnim)
	recthelper.setAnchor(slot0.go.transform, -slot4 + 40, 0)
	slot0:nextStep()
end

function slot0.nextStep(slot0)
	TaskDispatcher.cancelTask(slot0.nextStep, slot0)

	if not table.remove(slot0._allAnimWork, 1) then
		return
	end

	if slot1.destroy then
		gohelper.destroy(slot0.go)

		return
	elseif slot1.playAnim == "open" then
		slot1.anim.enabled = true
	else
		slot1.anim:Play(slot1.playAnim, 0, 0)
	end

	if not slot0._allAnimWork[1] then
		return
	end

	TaskDispatcher.runDelay(slot0.nextStep, slot0, slot2.time - slot1.time)
end

function slot0.sortAnim(slot0, slot1)
	return slot0.time < slot1.time
end

slot3 = typeof(UnityEngine.Animator)

function slot0.getRes(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot2, slot1)
	slot5 = slot3:GetComponent(uv0)

	gohelper.setActive(slot3, true)
	slot5:Play("open", 0, 0)
	slot5:Update(0)

	slot5.enabled = false

	return slot5, gohelper.findChildTextMesh(slot3, "txt")
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.nextStep, slot0)
end

return slot0
