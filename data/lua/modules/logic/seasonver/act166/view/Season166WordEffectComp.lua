module("modules.logic.seasonver.act166.view.Season166WordEffectComp", package.seeall)

slot0 = class("Season166WordEffectComp", LuaCompBase)
slot1 = "<size=40><alpha=#00>.<alpha=#ff></size>"
slot2 = table.insert
slot3 = string.gmatch

function slot4(slot0)
	if not slot0 then
		return {}
	end

	slot1 = {}

	for slot5 in uv0(slot0, "[%z-\\xc2-\\xf4][\\x80-\\xbf]*") do
		if LangSettings.instance:isEn() and slot5 == " " then
			slot5 = uv1
		end

		uv2(slot1, slot5)
	end

	return slot1
end

function slot0.ctor(slot0, slot1)
	slot0._co = slot1.co
	slot0._res = slot1.res
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._line1 = gohelper.findChild(slot1, "item/line1")
	slot0._line2 = gohelper.findChild(slot1, "item/line2")
	slot0._effect = gohelper.findChild(slot1, "item/effect")
	slot0._animEffect = slot0._effect:GetComponent(gohelper.Type_Animator)

	slot0:createTxt()
end

function slot0.createTxt(slot0)
	slot0._allAnimWork = {}
	slot3 = uv0(string.split(slot0._co.desc, "\n")[1]) or {}

	for slot8 = 1, #slot3 do
		slot9, slot10 = slot0:getRes(slot0._line1, false)
		slot10.text = slot3[slot8]
		slot4 = 0 + slot10.preferredWidth + Season166Enum.WordTxtPosXOffset

		recthelper.setWidth(slot10.transform.parent, slot10.preferredWidth)
		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot9,
			time = (slot8 - 1) * Season166Enum.WordTxtInterval
		})
		table.insert(slot0._allAnimWork, {
			playAnim = "close",
			anim = slot9,
			time = (slot8 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordTxtOpen + Season166Enum.WordTxtIdle + Season166Enum.WordTxtClose - Season166Enum.WordTxtClose
		})
	end

	slot5 = uv0(slot2[2]) or {}

	for slot9 = 1, #slot5 do
		slot10, slot11 = slot0:getRes(slot0._line2, false)
		slot11.text = slot5[slot9]
		slot4 = 0 + slot11.preferredWidth + Season166Enum.WordTxtPosXOffset

		recthelper.setWidth(slot11.transform.parent, slot11.preferredWidth)
		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot10,
			time = (slot9 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay
		})
		table.insert(slot0._allAnimWork, {
			playAnim = "close",
			anim = slot10,
			time = (slot9 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay + slot1 - Season166Enum.WordTxtClose
		})
	end

	slot6 = slot1 + Season166Enum.WordTxtInterval * (#slot3 - 1)
	slot7 = 0

	if #slot5 > 0 then
		slot7 = slot1 + Season166Enum.WordTxtInterval * (#slot5 - 1)
	end

	slot8 = math.max(slot6, slot7)

	table.insert(slot0._allAnimWork, {
		showEndEffect = true,
		time = slot8 - Season166Enum.WordTxtClose
	})
	table.insert(slot0._allAnimWork, {
		destroy = true,
		time = slot8
	})
	table.sort(slot0._allAnimWork, uv1.sortAnim)
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
	elseif slot1.showEndEffect then
		slot0._animEffect:Play(UIAnimationName.Close, 0, 0)
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

slot5 = typeof(UnityEngine.Animator)

function slot0.getRes(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._res, slot1)
	slot6 = slot3:GetComponent(uv0)

	gohelper.setActive(gohelper.findChildSingleImage(slot3, "img"), slot2)
	gohelper.setActive(gohelper.findChildTextMesh(slot3, "txt"), not slot2)
	gohelper.setActive(slot3, true)
	slot6:Play("open", 0, 0)
	slot6:Update(0)

	slot6.enabled = false

	return slot6, slot2 and slot4 or slot5
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.nextStep, slot0)
end

return slot0
