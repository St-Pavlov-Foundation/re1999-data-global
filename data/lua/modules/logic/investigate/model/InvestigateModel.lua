module("modules.logic.investigate.model.InvestigateModel", package.seeall)

local var_0_0 = class("InvestigateModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._newClueDict = nil
	arg_1_0._noPlayClueDict = nil
	arg_1_0._allUnLockClues = {}
	arg_1_0._waitFirstInit = true
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.refreshUnlock(arg_3_0, arg_3_1)
	if not arg_3_1 and arg_3_0._waitFirstInit then
		return
	end

	arg_3_0._waitFirstInit = false

	if arg_3_1 then
		arg_3_0._allUnLockClues = {}

		for iter_3_0, iter_3_1 in ipairs(lua_investigate_info.configList) do
			if iter_3_1.episode > 0 and DungeonModel.instance:hasPassLevel(iter_3_1.episode) then
				table.insert(arg_3_0._allUnLockClues, iter_3_1.id)
			end
		end
	else
		local var_3_0 = false

		for iter_3_2, iter_3_3 in ipairs(lua_investigate_info.configList) do
			if iter_3_3.episode > 0 and iter_3_3.entrance > 0 and not tabletool.indexOf(arg_3_0._allUnLockClues, iter_3_3.id) and DungeonModel.instance:hasPassLevel(iter_3_3.episode) then
				table.insert(arg_3_0._allUnLockClues, iter_3_3.id)
				arg_3_0:onGetNewId(iter_3_3.id)

				var_3_0 = true
			end
		end

		if var_3_0 then
			arg_3_0:_saveLocalData()
			InvestigateController.instance:dispatchEvent(InvestigateEvent.ClueUpdate)
		end
	end
end

function var_0_0.getAllNewIds(arg_4_0)
	arg_4_0:_initLocalData()

	return arg_4_0._newClueDict
end

function var_0_0.getAllNoPlayIds(arg_5_0)
	arg_5_0:_initLocalData()

	return arg_5_0._noPlayClueDict
end

function var_0_0.markAllNewIds(arg_6_0)
	if not arg_6_0._newClueDict[1] then
		return
	end

	arg_6_0._newClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew))
end

function var_0_0.markAllNoPlayIds(arg_7_0)
	if not arg_7_0._noPlayClueDict[1] then
		return
	end

	arg_7_0._noPlayClueDict = {}

	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim))
end

function var_0_0._initLocalData(arg_8_0)
	if not arg_8_0._newClueDict then
		arg_8_0._newClueDict = {}
		arg_8_0._noPlayClueDict = {}

		local var_8_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew), "")
		local var_8_1 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim), "")

		if not string.nilorempty(var_8_0) then
			arg_8_0._newClueDict = cjson.decode(var_8_0)
		end

		if not string.nilorempty(var_8_1) then
			arg_8_0._noPlayClueDict = cjson.decode(var_8_1)
		end
	end
end

function var_0_0.onGetNewId(arg_9_0, arg_9_1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.InvestigateClueView, {
			isGet = true,
			id = arg_9_1
		})

		return
	end

	arg_9_0:_initLocalData()
	table.insert(arg_9_0._newClueDict, arg_9_1)
	table.insert(arg_9_0._noPlayClueDict, arg_9_1)
	table.sort(arg_9_0._newClueDict)
	table.sort(arg_9_0._noPlayClueDict)
end

function var_0_0._saveLocalData(arg_10_0)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNew), cjson.encode(arg_10_0._newClueDict))
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.InvestigateNoPlayAnim), cjson.encode(arg_10_0._noPlayClueDict))
end

function var_0_0.isClueUnlock(arg_11_0, arg_11_1)
	return tabletool.indexOf(arg_11_0._allUnLockClues, arg_11_1)
end

function var_0_0.isHaveClue(arg_12_0)
	return arg_12_0._allUnLockClues[1] and true or false
end

function var_0_0.isGetAllClue(arg_13_0)
	return #arg_13_0._allUnLockClues == #lua_investigate_info.configList
end

var_0_0.instance = var_0_0.New()

return var_0_0
