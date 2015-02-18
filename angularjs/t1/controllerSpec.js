describe('Controller: ListCtrl', function () {
    beforeEach(module('notesApp'));

    var ctrl;

    beforeEach(inject(function ($controller) {
        ctrl = $controller('ListCtrl');
    }));

    it('should have items available on load', function () {
        expect(ctrl.items).toEqual([
            {id: 1, label: 'First', done: true},
            {id: 2, label: 'Second', done: false}
        ]);
    });
});