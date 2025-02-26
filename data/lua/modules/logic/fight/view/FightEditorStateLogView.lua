module("modules.logic.fight.view.FightEditorStateLogView", package.seeall)

slot0 = class("FightEditorStateLogView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnListRoot = gohelper.findChild(slot0.viewGO, "btnScrill/Viewport/Content")
	slot0._btnModel = gohelper.findChild(slot0._btnListRoot, "btnModel")
	slot0._logText = gohelper.findChildText(slot0.viewGO, "ScrollView/Viewport/Content/logText")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.processStr(slot0)
	slot2, slot3 = string.find(slot0, "cardInfoList.-heroId: [-%d]+")
	slot4 = ""
	slot5 = ""

	while slot2 do
		slot2, slot3 = string.find(string.sub(slot0, 1, slot2 - 1) .. string.gsub(string.gsub(string.gsub(string.sub(slot0, slot2, -1), "(uid: ([-%d]+))", function (slot0, slot1)
			slot2 = ""
			slot3 = ""

			if FightLocalDataMgr.instance:getEntityById(slot1) then
				slot3 = slot4:getEntityName()
			end

			return slot2 .. slot0 .. " 卡牌持有者:" .. slot3
		end, 1), "(skillId: ([-%d]+))", function (slot0, slot1)
			return "" .. slot0 .. " 技能名称:" .. (lua_skill.configDict[tonumber(slot1)] and slot4.name or "")
		end, 1), "(heroId: ([-%d]+))", function (slot0, slot1)
			return "" .. slot0 .. " 模型id(肉鸽支援技能牌会用到):" .. slot1
		end, 1), slot1, slot2 + 1)
	end

	slot2, slot3 = string.find(slot0, "modelId: %d+")

	while slot2 do
		slot2, slot3 = string.find(string.sub(slot0, 1, slot2 - 1) .. string.gsub(string.sub(slot0, slot2, -1), "(modelId: (%d+))", function (slot0, slot1)
			slot3 = lua_character.configDict[tonumber(slot1)] or lua_monster.configDict[slot2]

			return slot0 .. " 角色名称:" .. (slot3 and slot3.name or "")
		end, 1), slot1, slot2 + 1)
	end

	slot2, slot3 = string.find(slot0, "skin: [-%d]+")

	while slot2 do
		slot2, slot3 = string.find(string.sub(slot0, 1, slot2 - 1) .. string.gsub(string.sub(slot0, slot2, -1), "(skin: ([-%d]+))", function (slot0, slot1)
			return slot0 .. " 皮肤id:" .. slot1
		end, 1), slot1, slot2 + 1)
	end

	slot2, slot3 = string.find(slot0, "actType: [-%d]+")

	while slot2 do
		slot2, slot3 = string.find(string.sub(slot0, 1, slot2 - 1) .. string.gsub(string.sub(slot0, slot2, -1), "(actType: ([-%d]+))", function (slot0, slot1)
			if slot1 == "1" then
				return slot0 .. " 步骤类型:技能"
			elseif slot1 == "2" then
				return slot0 .. " 步骤类型:buff"
			elseif slot1 == "3" then
				return slot0 .. " 步骤类型:效果"
			elseif slot1 == "4" then
				return slot0 .. " 步骤类型:换人"
			elseif slot1 == "5" then
				return slot0 .. " 步骤类型:换波次时机（供客户端使用）"
			end

			return slot0
		end, 1), slot1, slot2 + 1)
	end

	slot2, slot3 = string.find(slot0, "步骤类型:技能")

	while slot2 do
		slot6 = nil
		slot2, slot3 = string.find(string.sub(slot0, 1, slot2 - 1) .. string.gsub(string.gsub(string.gsub(string.sub(slot0, slot2, -1), "(fromId: ([-%d]+))", function (slot0, slot1)
			slot2 = slot1
			slot3 = ""

			if slot1 == FightEntityScene.MySideId then
				slot3 = "维尔汀"
			elseif slot1 == FightEntityScene.EnemySideId then
				slot3 = "重塑之手"
			else
				uv0 = slot2

				if FightLocalDataMgr.instance:getEntityById(slot2) then
					slot3 = slot4:getEntityName()
				end
			end

			return slot0 .. " 技能发起者:" .. slot3
		end, 1), "(toId: ([-%d]+))", function (slot0, slot1)
			slot2 = slot1
			slot3 = ""

			if slot1 == FightEntityScene.MySideId then
				slot3 = "维尔汀"
			elseif slot1 == FightEntityScene.EnemySideId then
				slot3 = "重塑之手"
			elseif FightLocalDataMgr.instance:getEntityById(slot2) then
				slot3 = slot4:getEntityName()
			end

			return slot0 .. " 技能承受者:" .. slot3
		end, 1), "(actId: ([-%d]+))", function (slot0, slot1)
			return slot0 .. " 技能id:" .. slot1 .. " 技能名字:" .. (lua_skill.configDict[tonumber(slot1)] and slot3.name or "") .. " timeline : " .. FightLogHelper.getTimelineName(uv0, slot2)
		end, 1), slot1, slot2 + 1)
	end

	slot2, slot3 = string.find(slot0, "targetId: [-%d]+")

	while slot2 do
		slot2, slot3 = string.find(string.sub(slot0, 1, slot2 - 1) .. string.gsub(string.sub(slot0, slot2, -1), "(targetId: ([-%d]+))", function (slot0, slot1)
			slot2 = slot1
			slot3 = ""

			if slot1 == FightEntityScene.MySideId then
				slot3 = "维尔汀"
			elseif slot1 == FightEntityScene.EnemySideId then
				slot3 = "重塑之手"
			elseif FightLocalDataMgr.instance:getEntityById(slot2) then
				slot3 = slot4:getEntityName()
			end

			return slot0 .. " 作用对象:" .. slot3
		end, 1), slot1, slot2 + 1)
	end

	slot2, slot3 = string.find(slot0, "buffId: %d+")

	while slot2 do
		slot2, slot3 = string.find(string.sub(slot0, 1, slot2 - 1) .. string.gsub(string.sub(slot0, slot2, -1), "(buffId: ([-%d]+))", function (slot0, slot1)
			return slot0 .. " buff名称:" .. (lua_skill_buff.configDict[tonumber(slot1)] and slot3.name or "")
		end, 1), slot1, slot2 + 1)
	end

	return uv0.typeExplain(slot0)
end

function slot0.onOpen(slot0)
	slot0._type2FuncName = {}

	if not GameSceneMgr.instance:getCurScene().fightLog then
		return
	end

	slot0._strList = {}

	for slot6, slot7 in ipairs(slot1:getProtoList()) do
		if slot7.protoType == FightEnum.CacheProtoType.Round then
			slot0:addLog("回合" .. slot7.round)
			slot0:addLog(tostring(slot7.proto))
		elseif slot7.protoType == FightEnum.CacheProtoType.Fight then
			slot0:addLog("更新战场")
			slot0:addLog(tostring(slot7.proto))
		end
	end

	for slot7, slot8 in ipairs(slot0._strList) do
		slot3 = "" .. slot8 .. "\n"
	end

	slot0._logText.text = uv0.processStr(slot3)

	slot0:com_createObjList(slot0._onBtnItemShow, {
		{
			name = "复制"
		}
	}, slot0._btnListRoot, slot0._btnModel)
end

function slot0._onBtnItemShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "text").text = slot2.name

	slot0:addClickCb(gohelper.findChildClick(slot1, "btn"), slot0["_onBtnClick" .. slot3], slot0)
end

function slot0._onBtnClick1(slot0)
	ZProj.UGUIHelper.CopyText(slot0._logText.text)
end

function slot0.addLog(slot0, slot1)
	table.insert(slot0._strList, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.typeExplain(slot0)
	slot2 = io.open("Assets/ZProj/Scripts/Lua/modules/logic/fight/config/FightEnum.lua", "r")
	slot3 = slot2:read("*a")

	slot2:close()

	slot4, slot5 = string.find(slot3, "FightEnum.EffectType = {.-}")
	slot6 = {
		[slot10] = slot11
	}

	for slot10, slot11 in string.gmatch(string.gsub(string.sub(slot3, slot4, slot5), "FightEnum.EffectType =", ""), "=.-([-%d]+).-%-%-(.-)\n") do
		-- Nothing
	end

	slot4, slot5 = string.find(slot0, "effectType: [-%d]+")

	while slot4 do
		slot4, slot5 = string.find(string.sub(slot0, 1, slot4 - 1) .. string.gsub(string.sub(slot0, slot4, -1), "(effectType: ([-%d]+))", function (slot0, slot1)
			return slot0 .. " " .. (uv0[slot1] or "")
		end, 1), slot7, slot4 + 1)
	end

	return slot0
end

return slot0
