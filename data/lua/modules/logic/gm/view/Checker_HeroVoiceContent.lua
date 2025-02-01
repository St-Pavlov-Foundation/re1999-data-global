module("modules.logic.gm.view.Checker_HeroVoiceContent", package.seeall)

slot0 = class("Checker_HeroVoiceContent", Checker_Hero)
slot1 = string.split
slot2 = string.format

function slot3(slot0)
	slot0._okExec = true

	slot0:appendLine(uv0("%s(%s) skin %s: ", slot0:heroName(), slot0:heroId(), slot0:skinId()))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot4(slot0)
	slot0:subIndent()

	if slot0._okExec then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	end
end

function slot5(slot0, slot1)
	slot0._okLoop = true

	slot0:appendLine(uv0("audio %s: ", slot1.audio))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot6(slot0, slot1)
	slot0:subIndent()

	if slot0._okLoop then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	else
		slot0._okExec = false
	end
end

function slot7(slot0, slot1, slot2)
	slot0._okCheck = true

	slot0:appendLine(uv0("%s: ", slot2))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot8(slot0, slot1, slot2)
	slot0:subIndent()

	if slot0._okCheck then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	else
		slot0._okLoop = false
	end
end

function slot0.ctor(slot0, ...)
	Checker_Hero.ctor(slot0, ...)
end

function slot0._onExec_Spine(slot0, slot1)
	slot0:_onExecInner(slot1)
end

function slot0._onExec_Live2d(slot0, slot1)
	slot0:_onExecInner(slot1)
end

function slot0._onExecInner(slot0, slot1)
	uv0(slot0)

	for slot6, slot7 in ipairs(slot0:skincharacterVoiceCOList()) do
		uv1(slot0, slot7)
		slot0:_check(slot1, slot7, "content")
		slot0:_check(slot1, slot7, "twcontent")
		slot0:_check(slot1, slot7, "jpcontent")
		slot0:_check(slot1, slot7, "encontent")
		slot0:_check(slot1, slot7, "krcontent")
		uv2(slot0, slot7)
	end

	uv3(slot0)
end

function slot0._check(slot0, slot1, slot2, slot3)
	uv0(slot0, slot2, slot3)
	slot0:_onCheck(slot1, slot2[slot3])
	uv1(slot0, slot2, slot3)
end

function slot0._onCheck(slot0, slot1, slot2)
	if string.nilorempty(slot2) then
		return
	end

	for slot7 = #uv0(slot2, "|"), 1, -1 do
		if not string.nilorempty(uv0(slot3[slot7], "#")[1]) then
			slot12 = ""

			if string.nilorempty(tonumber(slot9[2])) then
				slot12 = "没有配置时间"
			elseif slot11 < 0 then
				if slot12 ~= "" then
					slot12 = slot12 .. ","
				end

				slot12 = slot12 .. "startTime(" .. tostring(slot11) .. ") < 0"
			end

			if slot12 ~= "" then
				slot0:appendLine("'" .. slot8 .. "': " .. slot12)

				slot0._okCheck = false
			end
		end
	end
end

return slot0
