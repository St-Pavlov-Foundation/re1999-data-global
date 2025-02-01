module("modules.logic.gm.model.GMResetCardsModel", package.seeall)

slot0 = class("GMResetCardsModel", BaseModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0._model1 = ListScrollModel.New()
	slot0._model2 = ListScrollModel.New()
end

function slot0.onInit(slot0)
	slot0._model1:onInit()
	slot0._model2:onInit()
end

function slot0.reInit(slot0)
	slot0._model1:reInit()
	slot0._model2:reInit()
end

function slot0.clear(slot0)
	slot0._model1:clear()
	slot0._model2:clear()
end

function slot0.getModel1(slot0)
	return slot0._model1
end

function slot0.getModel2(slot0)
	return slot0._model2
end

slot0.instance = slot0.New()

return slot0
