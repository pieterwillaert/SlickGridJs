package mediators {
import Slick.Column;
import Slick.Event;
import Slick.Grid;
import Slick.Options;
import Slick.RowSelectionModel;

import randori.behaviors.AbstractMediator;
import randori.jquery.JQuery;

public class IndexMediator extends AbstractMediator {

    [View] public var gridContainer:JQuery;

    private var grid:Grid;

    override protected function onRegister():void {
        var data:Array = new Array();
        for (var i:int = 0; i < 500; i++) {
            data[i] = {
                title: "Task " + i,
                duration: "5 days",
                percentComplete: Math.round(Math.random() * 100),
                start: "01/01/2009",
                finish: "01/05/2009",
                effortDriven: (i % 5 == 0)
            };
        }
        loadGrid( data );
    }


    protected function loadGrid( data:Array ):void {
        var col1:Column = new Column("title", "Title", "title" );
        var col2:Column = new Column("duration", "Duration", "duration" );
        var col3:Column = new Column("%", "% Complete", "percentComplete" );
        var col4:Column = new Column("start", "Start", "start" );
        var col5:Column = new Column("finish", "Finish", "finish" );
        var col6:Column = new Column("effort-driven", "Effort Driven", "effortDriven" );

        var columns:Array = [col1,col2,col3,col4,col5,col6];

        var options:Options = new Options();
        options.enableCellNavigation = false;
        options.enableColumnReorder = false;
        options.forceFitColumns = false; // should be false, see  https://github.com/mleibman/SlickGrid/issues/223

        grid = new Grid( gridContainer, data, columns, options);

        var selectionModel:Object = new RowSelectionModel();
        grid.setSelectionModel( selectionModel );

        grid.onSort.subscribe( basicSortFunction );
        grid.onDblClick.subscribe( cellDblClickHandler );
        grid.onClick.subscribe( cellClickHandler );
        grid.onSelectedRowsChanged.subscribe( rowChangedHandler );

    }

    private function basicSortFunction( e:Event, args:Object ):void{
        var field:Object = args.sortCol.field;

        args.grid.getData().sort(function(a, b):int{
            var result:int =
                    a[field] > b[field] ? 1 :
                            a[field] < b[field] ? -1 :
                                    0;

            return args.sortAsc ? result : -result;
        });

        args.grid.invalidate();
    }

    private function cellClickHandler( e:*, args:Object ):void {

    }
    private function rowChangedHandler( e:*, args:Object ):void {
    }
    private function cellDblClickHandler( e:*, args:Object  ):void {
        var selectedRow:int =  args.row;
        var selectedData:Object = args.grid.getData()[ selectedRow ];
    }


    override protected function onDeregister():void {

    }


}
}