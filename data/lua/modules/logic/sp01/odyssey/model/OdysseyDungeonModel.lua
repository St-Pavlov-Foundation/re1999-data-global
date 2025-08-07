module("modules.logic.sp01.odyssey.model.OdysseyDungeonModel", package.seeall)

local var_0_0 = class("OdysseyDungeonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.finishElementMap = {}
	arg_2_0.hasFinishElementMap = {}
	arg_2_0.newElementList = {}
	arg_2_0.isDraggingMap = false
	arg_2_0.isInMapSelectState = false
	arg_2_0.needFocusMainMapSelectItem = false
	arg_2_0.curInElementId = 0
	arg_2_0.mapInfoTab = {}
	arg_2_0.curElementMoTab = {}
	arg_2_0.jumpNeedOpenElement = 0
	arg_2_0.storyOptionParam = nil
	arg_2_0.elementFightParam = nil
	arg_2_0.curFightEpisodeId = nil
	arg_2_0.curMapId = nil
end

function var_0_0.updateMapInfo(arg_3_0, arg_3_1)
	arg_3_0:setMapInfo(arg_3_1.maps)
	arg_3_0:setCurInElementId(arg_3_1.currEleId)
	arg_3_0:setMapElementInfo(arg_3_1)
end

function var_0_0.setCurInElementId(arg_4_0, arg_4_1)
	arg_4_0.curInElementId = arg_4_1
end

function var_0_0.getCurInElementId(arg_5_0)
	return arg_5_0.curInElementId
end

function var_0_0.setMapInfo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = arg_6_0.mapInfoTab[iter_6_1.id]

		if not var_6_0 then
			var_6_0 = OdysseyMapMo.New()

			var_6_0:init(iter_6_1.id)

			arg_6_0.mapInfoTab[iter_6_1.id] = var_6_0
		end

		var_6_0:updateInfo(iter_6_1)
	end

	arg_6_0.mapInfoList = {}

	for iter_6_2, iter_6_3 in pairs(arg_6_0.mapInfoTab) do
		table.insert(arg_6_0.mapInfoList, iter_6_3)
	end

	table.sort(arg_6_0.mapInfoList, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)
end

function var_0_0.getMapInfo(arg_8_0, arg_8_1)
	return arg_8_0.mapInfoTab[arg_8_1]
end

function var_0_0.getMapInfoList(arg_9_0)
	return arg_9_0.mapInfoList
end

function var_0_0.setMapElementInfo(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1.finishedEleIds) do
		arg_10_0:setHasFinishElementMap(iter_10_1)
	end

	arg_10_0:setAllElementInfo(arg_10_1.elements)
end

function var_0_0.setHasFinishElementMap(arg_11_0, arg_11_1)
	arg_11_0.hasFinishElementMap[arg_11_1] = true
end

function var_0_0.setFinishElementMap(arg_12_0, arg_12_1)
	arg_12_0.finishElementMap[arg_12_1] = true
end

function var_0_0.setAllElementInfo(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		arg_13_0:updateElementInfo(iter_13_1)
	end
end

function var_0_0.updateElementInfo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.curElementMoTab[arg_14_1.id]

	if not var_14_0 then
		var_14_0 = OdysseyElementMo.New()

		var_14_0:init(arg_14_1.id)

		arg_14_0.curElementMoTab[arg_14_1.id] = var_14_0
	end

	var_14_0:updateInfo(arg_14_1)
end

function var_0_0.getElementMo(arg_15_0, arg_15_1)
	return arg_15_0.curElementMoTab[arg_15_1]
end

function var_0_0.getNewElementList(arg_16_0)
	return arg_16_0.newElementList
end

function var_0_0.cleanNewElements(arg_17_0)
	arg_17_0.newElementList = {}
end

function var_0_0.addNewElement(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if iter_18_1.status == OdysseyEnum.ElementStatus.Normal then
			local var_18_0 = OdysseyConfig.instance:getElementConfig(iter_18_1.id)

			table.insert(arg_18_0.newElementList, var_18_0)
		end
	end
end

function var_0_0.setDraggingMapState(arg_19_0, arg_19_1)
	arg_19_0.isDraggingMap = arg_19_1
end

function var_0_0.getDraggingMapState(arg_20_0)
	return arg_20_0.isDraggingMap
end

function var_0_0.setCurMapId(arg_21_0, arg_21_1)
	arg_21_0.curMapId = arg_21_1
end

function var_0_0.getCurMapId(arg_22_0)
	return arg_22_0.curMapId or arg_22_0:getHeroInMapId()
end

function var_0_0.getHeroInMapId(arg_23_0)
	local var_23_0 = OdysseyConfig.instance:getElementConfig(arg_23_0.curInElementId)

	return var_23_0 and var_23_0.mapId or 1
end

function var_0_0.getElemenetInMapId(arg_24_0, arg_24_1)
	local var_24_0 = OdysseyConfig.instance:getElementConfig(arg_24_1)

	return var_24_0 and var_24_0.mapId or 0
end

function var_0_0.getCurAllElementCoList(arg_25_0, arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0.curElementMoTab) do
		if arg_25_0:checkElementCanShow(arg_25_1, iter_25_0) then
			table.insert(var_25_0, iter_25_1.config)
		end
	end

	return var_25_0
end

function var_0_0.checkElementCanShow(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:isElementFinish(arg_26_2)
	local var_26_1 = arg_26_0.curElementMoTab[arg_26_2]

	return var_26_1 and var_26_1.config and var_26_1.config.mapId == arg_26_1 and not var_26_0
end

function var_0_0.getCurMainElement(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.mapInfoTab) do
		local var_27_0 = arg_27_0:getCurAllElementCoList(iter_27_0)

		for iter_27_2, iter_27_3 in ipairs(var_27_0) do
			if iter_27_3.main == OdysseyEnum.DungeonMainElement then
				return iter_27_1.config, iter_27_3
			end
		end
	end
end

function var_0_0.isElementFinish(arg_28_0, arg_28_1)
	return arg_28_0.finishElementMap[arg_28_1]
end

function var_0_0.setLastElementFightParam(arg_29_0, arg_29_1)
	arg_29_0.elementFightParam = {}
	arg_29_0.elementFightParam.lastEpisodeId = arg_29_1.episodeId
	arg_29_0.elementFightParam.lastElementId = arg_29_1.elementId

	arg_29_0:setCurFightEpisodeId(arg_29_1.episodeId)
end

function var_0_0.getLastElementFightParam(arg_30_0)
	return arg_30_0.elementFightParam
end

function var_0_0.cleanLastElementFightParam(arg_31_0)
	arg_31_0.elementFightParam = nil
end

function var_0_0.setCurFightEpisodeId(arg_32_0, arg_32_1)
	arg_32_0.curFightEpisodeId = arg_32_1
end

function var_0_0.getCurFightEpisodeId(arg_33_0)
	return arg_33_0.curFightEpisodeId
end

function var_0_0.checkConditionCanUnlock(arg_34_0, arg_34_1)
	local var_34_0 = true

	if string.nilorempty(arg_34_1) then
		return var_34_0
	end

	local var_34_1 = {}
	local var_34_2 = GameUtil.splitString2(arg_34_1)

	for iter_34_0, iter_34_1 in ipairs(var_34_2) do
		if iter_34_1[1] == OdysseyEnum.ConditionType.Time then
			local var_34_3 = tonumber(iter_34_1[2])
			local var_34_4 = ActivityModel.instance:getActMO(VersionActivity2_9Enum.ActivityId.Dungeon2)

			if var_34_4 then
				local var_34_5 = var_34_4:getRealStartTimeStamp() + var_34_3 * TimeUtil.OneDaySecond - ServerTime.now()

				if var_34_5 > 0 then
					var_34_0 = false
				end

				var_34_1 = {
					type = iter_34_1[1],
					remainTimeStamp = var_34_5
				}
			else
				var_34_0 = false
				var_34_1 = {
					remainTimeStamp = 0,
					type = iter_34_1[1]
				}
			end
		elseif iter_34_1[1] == OdysseyEnum.ConditionType.Finish then
			if not arg_34_0:isElementFinish(tonumber(iter_34_1[2])) then
				var_34_0 = false
			end

			var_34_1 = {
				type = iter_34_1[1],
				elementId = tonumber(iter_34_1[2])
			}
		elseif iter_34_1[1] == iter_34_1[1] == OdysseyEnum.ConditionType.FinishOption then
			if not arg_34_0:isElementFinish(tonumber(iter_34_1[2])) then
				var_34_0 = false
			end

			var_34_1 = {
				type = iter_34_1[1],
				elementId = tonumber(iter_34_1[2])
			}
		elseif iter_34_1[1] == OdysseyEnum.ConditionType.Level then
			local var_34_6 = OdysseyModel.instance:getHeroCurLevelAndExp()

			if var_34_6 < tonumber(iter_34_1[2]) then
				var_34_0 = false
			end

			var_34_1 = {
				type = iter_34_1[1],
				heroLevel = var_34_6,
				unlockLevel = tonumber(iter_34_1[2])
			}
		elseif iter_34_1[1] == OdysseyEnum.ConditionType.Item then
			local var_34_7 = tonumber(iter_34_1[2])
			local var_34_8 = tonumber(iter_34_1[3])
			local var_34_9 = OdysseyItemModel.instance:getItemCount(var_34_7)

			if var_34_9 < var_34_8 then
				var_34_0 = false
			end

			var_34_1 = {
				type = iter_34_1[1],
				curItemCount = var_34_9,
				itemId = tonumber(iter_34_1[2]),
				unlockItemCount = tonumber(iter_34_1[3])
			}
		end

		if not var_34_0 then
			break
		end
	end

	return var_34_0, var_34_1
end

function var_0_0.getCurMercenaryElements(arg_35_0)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in pairs(arg_35_0.curElementMoTab) do
		if not iter_35_1.config then
			logError(iter_35_1.id .. "元件配置不存在")
		end

		if iter_35_1.config and iter_35_1.config.type == OdysseyEnum.ElementType.Fight and not iter_35_1:isFinish() then
			local var_35_1 = OdysseyConfig.instance:getElementFightConfig(iter_35_1.id)

			if var_35_1 and var_35_1.type == OdysseyEnum.FightType.Mercenary then
				table.insert(var_35_0, iter_35_1)
			end
		end
	end

	return var_35_0
end

function var_0_0.getMercenaryElementsByMap(arg_36_0, arg_36_1)
	local var_36_0 = {}
	local var_36_1 = arg_36_0:getCurMercenaryElements()

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		if iter_36_1.config.mapId == arg_36_1 then
			table.insert(var_36_0, iter_36_1)
		end
	end

	return var_36_0
end

function var_0_0.getMapFightElementMoList(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(arg_37_0.curElementMoTab) do
		if iter_37_1.config.type == OdysseyEnum.ElementType.Fight and iter_37_1.config.mapId == arg_37_1 then
			local var_37_1 = OdysseyConfig.instance:getElementFightConfig(iter_37_1.id)

			if var_37_1 and var_37_1.type == arg_37_2 then
				table.insert(var_37_0, iter_37_1)
			end
		end
	end

	return var_37_0
end

function var_0_0.getMapNotFinishFightElementMoList(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(arg_38_0.curElementMoTab) do
		if iter_38_1.config.type == OdysseyEnum.ElementType.Fight and iter_38_1.config.mapId == arg_38_1 then
			local var_38_1 = OdysseyConfig.instance:getElementFightConfig(iter_38_1.id)
			local var_38_2 = arg_38_0:isElementFinish(iter_38_1.id)

			if var_38_1 and var_38_1.type == arg_38_2 and not var_38_2 then
				table.insert(var_38_0, iter_38_1)
			end
		end
	end

	return var_38_0
end

function var_0_0.setIsMapSelect(arg_39_0, arg_39_1)
	arg_39_0.isInMapSelectState = arg_39_1
end

function var_0_0.getIsInMapSelectState(arg_40_0)
	return arg_40_0.isInMapSelectState
end

function var_0_0.setNeedFocusMainMapSelectItem(arg_41_0, arg_41_1)
	arg_41_0.needFocusMainMapSelectItem = arg_41_1
end

function var_0_0.getNeedFocusMainMapSelectItem(arg_42_0)
	return arg_42_0.needFocusMainMapSelectItem
end

function var_0_0.setJumpNeedOpenElement(arg_43_0, arg_43_1)
	arg_43_0.jumpNeedOpenElement = arg_43_1
end

function var_0_0.getJumpNeedOpenElement(arg_44_0)
	return arg_44_0.jumpNeedOpenElement
end

function var_0_0.setStoryOptionParam(arg_45_0, arg_45_1)
	arg_45_0.storyOptionParam = arg_45_1
end

function var_0_0.getStoryOptionParam(arg_46_0)
	return arg_46_0.storyOptionParam
end

function var_0_0.getMapRes(arg_47_0, arg_47_1)
	return OdysseyConfig.instance:getDungeonMapConfig(arg_47_1).res
end

function var_0_0.getMythCoMyMapId(arg_48_0, arg_48_1)
	local var_48_0 = OdysseyConfig.instance:getMythConfigList()

	for iter_48_0, iter_48_1 in ipairs(var_48_0) do
		if arg_48_0:getElemenetInMapId(iter_48_1.elementId) == arg_48_1 then
			return iter_48_1
		end
	end
end

function var_0_0.checkHasFightTypeElement(arg_49_0, arg_49_1)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.curElementMoTab) do
		if iter_49_1.config and iter_49_1.config.type == OdysseyEnum.ElementType.Fight then
			local var_49_0 = OdysseyConfig.instance:getElementFightConfig(iter_49_1.id)

			if var_49_0 and var_49_0.type == arg_49_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.getCanAutoExposeReligionCoList(arg_50_0)
	local var_50_0 = {}
	local var_50_1 = OdysseyConfig.instance:getReligionConfigList()

	for iter_50_0, iter_50_1 in ipairs(var_50_1) do
		if iter_50_1.autoExpose == 1 and not OdysseyModel.instance:getReligionInfoData(iter_50_1.id) then
			table.insert(var_50_0, iter_50_1)
		end
	end

	return var_50_0
end

function var_0_0.checkHasNewUnlock(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0:getCurSaveLocalNewUnlock(arg_51_1)
	local var_51_1 = {}

	for iter_51_0, iter_51_1 in ipairs(arg_51_2) do
		if not tabletool.indexOf(var_51_0, iter_51_1) then
			table.insert(var_51_1, iter_51_1)
		end
	end

	return #var_51_1 > 0, var_51_1
end

function var_0_0.saveLocalCurNewLock(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0:getCurSaveLocalNewUnlock(arg_52_1)
	local var_52_1 = var_52_0

	for iter_52_0, iter_52_1 in ipairs(arg_52_2) do
		if not tabletool.indexOf(var_52_0, iter_52_1) then
			table.insert(var_52_1, iter_52_1)
		end
	end

	OdysseyDungeonController.instance:setPlayerPrefs(arg_52_1, table.concat(var_52_1, "#"))
end

function var_0_0.getCurSaveLocalNewUnlock(arg_53_0, arg_53_1)
	local var_53_0 = OdysseyDungeonController.instance:getPlayerPrefs(arg_53_1, "")
	local var_53_1 = {}

	if not string.nilorempty(var_53_0) then
		var_53_1 = string.splitToNumber(var_53_0, "#")
	end

	return var_53_1
end

function var_0_0.getCurUnlockMythIdList(arg_54_0)
	local var_54_0 = {}
	local var_54_1 = OdysseyConfig.instance:getMythConfigList()

	for iter_54_0, iter_54_1 in ipairs(var_54_1) do
		if arg_54_0:getElementMo(iter_54_1.elementId) then
			table.insert(var_54_0, iter_54_1.id)
		end
	end

	return var_54_0
end

function var_0_0.getCurUnlockMapIdList(arg_55_0)
	local var_55_0 = {}
	local var_55_1 = OdysseyConfig.instance:getAllDungeonMapCoList()

	for iter_55_0, iter_55_1 in ipairs(var_55_1) do
		if arg_55_0:getMapInfo(iter_55_1.id) then
			table.insert(var_55_0, iter_55_1.id)
		end
	end

	return var_55_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
