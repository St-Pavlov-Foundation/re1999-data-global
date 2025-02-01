module("modules.logic.toughbattle.view.ToughBattleWordComp", package.seeall)

slot0 = class("ToughBattleWordComp", LuaCompBase)
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

function slot0.ctor(slot0, slot1)
	slot0._co = slot1.co
	slot0._res = slot1.res
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._sign = gohelper.findChild(slot1, "sign")
	slot0._line1 = gohelper.findChild(slot1, "line1")
	slot0._line2 = gohelper.findChild(slot1, "line2")

	slot0:createTxt()
end

function slot0.createTxt(slot0)
	slot0._allAnimWork = {}
	slot2, slot3 = slot0:getRes(slot0._sign, true)

	slot3:LoadImage(ResUrl.getSignature(slot0._co.sign))

	for slot9 = 1, #uv0(string.split(slot0._co.desc, "\n")[1]) do
		slot10, slot11 = slot0:getRes(slot0._line1, false)
		slot11.text = slot5[slot9]

		recthelper.setWidth(slot11.transform.parent, slot11.preferredWidth)
		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot10,
			time = (slot9 - 1) * ToughBattleEnum.WordTxtInterval
		})
		table.insert(slot0._allAnimWork, {
			playAnim = "close",
			anim = slot10,
			time = (slot9 - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordTxtOpen + ToughBattleEnum.WordTxtIdle + ToughBattleEnum.WordTxtClose - ToughBattleEnum.WordTxtClose
		})
	end

	for slot10 = 1, #uv0(slot4[2]) do
		slot11, slot12 = slot0:getRes(slot0._line2, false)
		slot12.text = slot6[slot10]

		recthelper.setWidth(slot12.transform.parent, slot12.preferredWidth)
		table.insert(slot0._allAnimWork, {
			playAnim = "open",
			anim = slot11,
			time = (slot10 - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay
		})
		table.insert(slot0._allAnimWork, {
			playAnim = "close",
			anim = slot11,
			time = (slot10 - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay + slot1 - ToughBattleEnum.WordTxtClose
		})
	end

	table.insert(slot0._allAnimWork, {
		playAnim = "open",
		time = 0,
		anim = slot2
	})

	slot7 = slot1 + ToughBattleEnum.WordTxtInterval * (#slot5 - 1)
	slot8 = 0

	if #slot6 > 0 then
		slot8 = slot1 + ToughBattleEnum.WordTxtInterval * (#slot6 - 1)
	end

	slot9 = math.max(slot7, slot8)

	table.insert(slot0._allAnimWork, {
		playAnim = "close",
		anim = slot2,
		time = slot9 - ToughBattleEnum.WordTxtClose
	})
	table.insert(slot0._allAnimWork, {
		destroy = true,
		time = slot9
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
