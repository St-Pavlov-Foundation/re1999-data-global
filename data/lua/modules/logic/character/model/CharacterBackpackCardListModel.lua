module("modules.logic.character.model.CharacterBackpackCardListModel", package.seeall)

local var_0_0 = class("CharacterBackpackCardListModel", ListScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._characterFirstToShow = nil
end

function var_0_0.updateModel(arg_2_0)
	arg_2_0.moList = arg_2_0.moList or {}

	arg_2_0:setList(arg_2_0.moList)
end

function var_0_0.setFirstShowCharacter(arg_3_0, arg_3_1)
	arg_3_0._characterFirstToShow = arg_3_1
end

function var_0_0._doCharacterFirst(arg_4_0, arg_4_1)
	if not arg_4_0._characterFirstToShow then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1.heroId == arg_4_0._characterFirstToShow then
			table.remove(arg_4_1, iter_4_0)
			table.insert(arg_4_1, 1, iter_4_1)

			break
		end
	end
end

function var_0_0.setCharacterCardList(arg_5_0, arg_5_1)
	arg_5_0.moList = arg_5_1 or {}

	arg_5_0:_doCharacterFirst(arg_5_0.moList)
	arg_5_0:setList(arg_5_0.moList)
end

function var_0_0.getCharacterCardList(arg_6_0)
	return arg_6_0:getList()
end

function var_0_0.setCharacterViewDragMOList(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or arg_7_0.moList
	arg_7_0.characterViewDragMOList = {}

	if not arg_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(arg_7_0.characterViewDragMOList, iter_7_1)
	end
end

function var_0_0.getNextCharacterCard(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_0.characterViewDragMOList then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.characterViewDragMOList) do
			if iter_8_1.heroId == arg_8_1 then
				return iter_8_0 ~= #arg_8_0.characterViewDragMOList and arg_8_0.characterViewDragMOList[iter_8_0 + 1] or arg_8_0.characterViewDragMOList[1]
			end
		end
	end
end

function var_0_0.getLastCharacterCard(arg_9_0, arg_9_1)
	local var_9_0

	if arg_9_0.characterViewDragMOList then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.characterViewDragMOList) do
			if iter_9_1.heroId == arg_9_1 then
				return iter_9_0 ~= 1 and arg_9_0.characterViewDragMOList[iter_9_0 - 1] or arg_9_0.characterViewDragMOList[#arg_9_0.characterViewDragMOList]
			end
		end
	end
end

function var_0_0.clearCardList(arg_10_0)
	arg_10_0.moList = nil

	arg_10_0:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
