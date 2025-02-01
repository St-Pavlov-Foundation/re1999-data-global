module("modules.logic.gm.view.Checker_HeroVoiceMouth", package.seeall)

slot0 = class("Checker_HeroVoiceMouth", Checker_Hero)
slot1 = string.split
slot2 = string.format
slot3 = "auto_bizui|"
slot4 = "pause"
slot5 = "_auto"

function slot6(slot0)
	slot0._okExec = true

	slot0:appendLine(uv0("%s(%s) skin %s: ", slot0:heroName(), slot0:heroId(), slot0:skinId()))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot7(slot0)
	slot0:subIndent()

	if slot0._okExec then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	end
end

function slot8(slot0, slot1)
	slot0._okLoop = true

	slot0:appendLine(uv0("audio %s: ", slot1.audio))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot9(slot0, slot1)
	slot0:subIndent()

	if slot0._okLoop then
		slot0:pushIndent()
		slot0:appendWithIndex(slot0:makeColorStr("ok", Checker_Base.Color.Green), slot0:popMarkLine())
		slot0:popIndent()
	else
		slot0._okExec = false
	end
end

function slot10(slot0, slot1, slot2)
	slot0._okCheck = true

	slot0:appendLine(uv0("%s: ", slot2))
	slot0:pushMarkLine()
	slot0:addIndent()
end

function slot11(slot0, slot1, slot2)
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

	slot0._mouthActionList = {
		[AudioMgr.instance:getIdFromString("Smallmouth")] = "xiao",
		[AudioMgr.instance:getIdFromString("Mediumsizedmouth")] = "zhong",
		[AudioMgr.instance:getIdFromString("Largemouth")] = "da"
	}
end

function slot0._onExec_Spine(slot0, slot1)
	slot0:_onExecInner(slot1, slot1.hasAnimation)
end

function slot0._onExec_Live2d(slot0, slot1)
	slot0:_onExecInner(slot1, slot1.hasExpression)
end

function slot0._onExecInner(slot0, slot1, slot2)
	uv0(slot0)

	for slot7, slot8 in ipairs(slot0:skincharacterVoiceCOList()) do
		uv1(slot0, slot8)
		slot0:_check(slot1, slot2, slot8, "mouth")
		slot0:_check(slot1, slot2, slot8, "twmouth")
		slot0:_check(slot1, slot2, slot8, "jpmouth")
		slot0:_check(slot1, slot2, slot8, "enmouth")
		slot0:_check(slot1, slot2, slot8, "krmouth")
		uv2(slot0, slot8)
	end

	uv3(slot0)
end

function slot0._check(slot0, slot1, slot2, slot3, slot4)
	uv0(slot0, slot3, slot4)
	slot0:_onCheck(slot1, slot2, slot3[slot4])
	uv1(slot0, slot3, slot4)
end

function slot0._onCheck(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot3) then
		return
	end

	if string.find(slot3, uv0) then
		if not slot2(slot1, StoryAnimName.T_BiZui) then
			slot0:appendLine("'" .. uv0 .. "': " .. ("not exist animation '" .. tostring(slot4) .. "'"))

			slot0._okCheck = false
		end

		slot3 = string.gsub(slot3, uv0, "")
	end

	for slot8 = #uv1(slot3, "|"), 1, -1 do
		slot9 = slot4[slot8]
		slot10 = uv1(slot9, "#")
		slot11 = ""

		if not string.find(slot9, uv2) then
			slot12 = "t_" .. tostring(slot10[1])

			if not (slot10[1] == uv3) and not slot2(slot1, slot12) then
				slot11 = "not exist animation '" .. tostring(slot12) .. "'"
			end

			slot15 = tonumber(slot10[3])
			slot16 = nil

			if tonumber(slot10[2]) and slot15 then
				slot16 = slot15 - slot14
			end

			if not slot16 then
				if not slot14 then
					if slot11 ~= "" then
						slot11 = slot11 .. ","
					end

					slot11 = slot11 .. "startTime == nil"
				end

				if not slot15 then
					if slot11 ~= "" then
						slot11 = slot11 .. ","
					end

					slot11 = slot11 .. "endTime == nil"
				end
			elseif slot16 <= 0 then
				if slot11 ~= "" then
					slot11 = slot11 .. ","
				end

				slot11 = slot11 .. "duration <= 0"
			end
		end

		if slot11 ~= "" then
			slot0:appendLine("'" .. slot9 .. "': " .. slot11)

			slot0._okCheck = false
		end
	end
end

return slot0
