module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElements", package.seeall)

local var_0_0 = class("FairyLandElements", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goElements = gohelper.findChild(arg_1_0.viewGO, "main/#go_Root/#go_Elements")
	arg_1_0.goPool = gohelper.findChild(arg_1_0.goElements, "pool")
	arg_1_0.wordRes1 = gohelper.findChild(arg_1_0.goPool, "word1")
	arg_1_0.wordRes2 = gohelper.findChild(arg_1_0.goPool, "word2")
	arg_1_0.elementDict = {}
	arg_1_0.textDict = {}
	arg_1_0.elementTypeDict = {}
	arg_1_0.templateObjDict = {}
	arg_1_0.element2ObjName = {
		[FairyLandEnum.ElementType.Circle] = "circle",
		[FairyLandEnum.ElementType.Square] = "square",
		[FairyLandEnum.ElementType.Triangle] = "triangle",
		[FairyLandEnum.ElementType.Rectangle] = "rectangle",
		[FairyLandEnum.ElementType.NPC] = "npc",
		[FairyLandEnum.ElementType.Character] = "character",
		[FairyLandEnum.ElementType.Door] = "door",
		[FairyLandEnum.ElementType.Text] = "text"
	}
	arg_1_0.element2Cls = {
		[FairyLandEnum.ElementType.Circle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Square] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Triangle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Rectangle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.NPC] = FairyLandChessNpc,
		[FairyLandEnum.ElementType.Character] = FairyLandChessSelf,
		[FairyLandEnum.ElementType.Door] = FairyLandElementDoor
	}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.element2ObjName) do
		arg_1_0.templateObjDict[iter_1_0] = gohelper.findChild(arg_1_0.goPool, iter_1_1)
	end

	arg_1_0.characterId = 0
	arg_1_0.characterType = 0

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.DialogFinish, arg_2_0.updateElements, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.UpdateInfo, arg_2_0.updateElements, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.ElementFinish, arg_2_0.onElementFinish, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.SceneLoadFinish, arg_2_0.initElements, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.initElements(arg_6_0)
	arg_6_0:updateElements()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ElementLoadFinish)
end

function var_0_0.onElementFinish(arg_7_0)
	arg_7_0:updateElements()
end

function var_0_0.updateElements(arg_8_0)
	local var_8_0 = FairyLandConfig.instance:getElements()
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_2 = iter_8_1.id

		if FairyLandModel.instance:isFinishElement(var_8_2) then
			if var_8_1 < var_8_2 then
				var_8_1 = var_8_2
			end

			arg_8_0:removeElement(var_8_2)
		elseif arg_8_0.elementDict[var_8_2] then
			arg_8_0:updateElement(var_8_2)
		else
			arg_8_0:createElement(var_8_2)
		end
	end

	if arg_8_0.elementDict[arg_8_0.characterId] then
		arg_8_0:updateElement(arg_8_0.characterId)
	else
		arg_8_0:createCharacter()
	end

	arg_8_0:refreshText()

	local var_8_3 = FairyLandModel.instance:getLatestFinishedPuzzle()

	FairyLandController.instance:dispatchEvent(FairyLandEvent.GuideLatestElementFinish, var_8_1)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.GuideLatestPuzzleFinish, var_8_3)
end

function var_0_0.createCharacter(arg_9_0)
	local var_9_0 = FairyLandEnum.ConfigType2ElementType[arg_9_0.characterType]
	local var_9_1 = arg_9_0.element2Cls[var_9_0]
	local var_9_2 = {
		pos = FairyLandModel.instance:getStairPos()
	}
	local var_9_3 = var_9_1.New(arg_9_0, var_9_2)
	local var_9_4 = gohelper.clone(arg_9_0.templateObjDict[var_9_0], arg_9_0.goElements, tostring(arg_9_0.characterId))

	gohelper.setActive(var_9_4, true)
	var_9_3:init(var_9_4)

	arg_9_0.elementDict[arg_9_0.characterId] = var_9_3

	arg_9_0:addTypeDict(arg_9_0.characterType, arg_9_0.characterId)
end

function var_0_0.createElement(arg_10_0, arg_10_1)
	local var_10_0 = FairyLandConfig.instance:getElementConfig(arg_10_1)

	if not var_10_0 then
		return
	end

	local var_10_1 = FairyLandEnum.ConfigType2ElementType[var_10_0.type]
	local var_10_2 = arg_10_0.element2Cls[var_10_1].New(arg_10_0, var_10_0)
	local var_10_3 = gohelper.clone(arg_10_0.templateObjDict[var_10_1], arg_10_0.goElements, tostring(arg_10_1))

	gohelper.setActive(var_10_3, true)
	var_10_2:init(var_10_3)

	arg_10_0.elementDict[arg_10_1] = var_10_2

	arg_10_0:addTypeDict(var_10_0.type, arg_10_1)
end

function var_0_0.addTypeDict(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0.elementTypeDict[arg_11_1] then
		arg_11_0.elementTypeDict[arg_11_1] = {}
	end

	table.insert(arg_11_0.elementTypeDict[arg_11_1], arg_11_2)
end

function var_0_0.updateElement(arg_12_0, arg_12_1)
	if not arg_12_0.elementDict[arg_12_1] then
		return
	end

	arg_12_0.elementDict[arg_12_1]:refresh()
end

function var_0_0.removeElement(arg_13_0, arg_13_1)
	if not arg_13_0.elementDict[arg_13_1] then
		return
	end

	arg_13_0.elementDict[arg_13_1]:finish()

	arg_13_0.elementDict[arg_13_1] = nil
end

function var_0_0.getElementByType(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or arg_14_0.characterType

	local var_14_0 = arg_14_0.elementTypeDict[arg_14_1]
	local var_14_1 = var_14_0 and var_14_0[#var_14_0]

	return var_14_1 and arg_14_0.elementDict[var_14_1]
end

function var_0_0.refreshText(arg_15_0)
	local var_15_0 = 10
	local var_15_1 = FairyLandConfig.instance:getFairlyLandPuzzleConfig(var_15_0).storyTalkId

	if FairyLandModel.instance:isFinishDialog(var_15_1) then
		local var_15_2 = FairyLandModel.instance:getStairPos()
		local var_15_3 = lua_fairyland_text.configList
		local var_15_4 = 35

		for iter_15_0, iter_15_1 in ipairs(var_15_3) do
			if var_15_2 >= iter_15_1.node then
				if not arg_15_0.textDict[iter_15_1.id] then
					local var_15_5 = FairyLandText.New(arg_15_0, {
						pos = var_15_4 + (iter_15_1.id - 1) * 1.8,
						config = iter_15_1
					})
					local var_15_6 = gohelper.clone(arg_15_0.templateObjDict[FairyLandEnum.ElementType.Text], arg_15_0.goElements, string.format("text%s", tostring(iter_15_1.id)))

					gohelper.setActive(var_15_6, true)
					var_15_5:init(var_15_6)

					arg_15_0.textDict[iter_15_1.id] = var_15_5
				end

				arg_15_0.textDict[iter_15_1.id]:show()
			elseif arg_15_0.textDict[iter_15_1.id] then
				arg_15_0.textDict[iter_15_1.id]:hide()
			end
		end
	else
		for iter_15_2, iter_15_3 in pairs(arg_15_0.textDict) do
			iter_15_3:hide()
		end
	end
end

function var_0_0.characterMove(arg_16_0)
	if arg_16_0.elementDict[arg_16_0.characterId] then
		arg_16_0.elementDict[arg_16_0.characterId]:move()
	end
end

function var_0_0.isMoveing(arg_17_0)
	if arg_17_0.elementDict[arg_17_0.characterId] then
		return arg_17_0.elementDict[arg_17_0.characterId]:isMoveing()
	end
end

function var_0_0.onDestroyView(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.elementDict) do
		iter_18_1:onDestroy()
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0.textDict) do
		iter_18_3:onDestroy()
	end

	arg_18_0.elementDict = nil
end

return var_0_0
