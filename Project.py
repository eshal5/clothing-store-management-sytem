from PyQt6 import QtWidgets, uic, QtCore
import random
from PyQt6.QtCore import Qt
from PyQt6.QtCore import QEvent
from PyQt6.QtWidgets import QDialog
from PyQt6.QtWidgets import QWidget
from PyQt6.QtWidgets import QTableWidgetItem
from PyQt6.QtWidgets import QVBoxLayout
from PyQt6.QtWidgets import QCalendarWidget
from PyQt6.QtWidgets import QHeaderView
from PyQt6.QtWidgets import QMessageBox
from PyQt6.QtWidgets import QLineEdit
from PyQt6.QtWidgets import QPushButton
from PyQt6.QtWidgets import QComboBox
from PyQt6.QtCore import pyqtSignal
import sys
import pyodbc
import os


server = 'DESKTOP-VAOMLNG'
database = 'CLOTHING STORE'
use_windows_authentication = False
username = 'sa'
password = 'Password_08433'

if use_windows_authentication:
    connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'
else:
    connection_string = f'DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'


class UI(QtWidgets.QMainWindow):
    def __init__(self):
        super(UI, self).__init__()
        uic.loadUi(os.path.abspath('user.ui'), self)
        self.show()
        self.ADMIN.clicked.connect(self.handle_click)
        self.CUSTOMER.clicked.connect(self.manage_click)

    def handle_click(self):
        self.view_form_window = SecondUI()
        self.view_form_window.show()
        self.hide()

    def manage_click(self):
        print("temp")
        self.view_c_window = A()
        self.view_c_window.show()
        # self.hide()
# ------------------------------------------------------------------------------------------ADMIN


class SecondUI(QtWidgets.QMainWindow):
    def __init__(self):
        super(SecondUI, self).__init__()
        uic.loadUi('adminlogin.ui', self)
        self.EnterPassword.clicked.connect(self.handle_enter)

    def handle_enter(self):
        text1 = self.password.text()
        if text1 == "abc":
            self.view_form_window = AdminView()
            self.view_form_window.show()
            # self.hide()
        else:
            msg_box = QtWidgets.QMessageBox()
            msg_box.setWindowTitle("Wrong Password")
            msg_box.setText("Wrong Password entered. Try Again!")
            msg_box.setIcon(QtWidgets.QMessageBox.Icon.Information)
            result = msg_box.exec()


class AdminView(QtWidgets.QMainWindow):
    def __init__(self):
        super(AdminView, self).__init__()
        uic.loadUi('ADview.ui', self)
        self.warehouse.clicked.connect(self.handle_warehouse)
        self.seller.clicked.connect(self.handle_seller)
        self.customer.clicked.connect(self.handle_customer)
        self.complaints.clicked.connect(self.handle_complaint)
        self.distributor.clicked.connect(self.handle_distributor)
        self.orderbutton.clicked.connect(self.handleorders)
    def handleorders(self):
        self.view_form_window=ORDERS()
        self.view_form_window.show()


    def handle_warehouse(self):
        self.view_form_window = WarehouseUI()
        self.view_form_window.show()
        # self.hide()

    def handle_seller(self):
        self.view_form_window = SellerUI()
        self.view_form_window.show()
        # self.hide()

    def handle_customer(self):
        self.view_form_window = CustomerUI()
        self.view_form_window.show()
        # self.hide()

    def handle_distributor(self):
        self.view_form_window = DistributorDetailsUI()
        self.view_form_window.show()
        # self.hide()
#####################

    def handle_complaint(self):
        self.view_form_window = ComplaintUI()
        self.view_form_window.show()


class ORDERS(QtWidgets.QMainWindow):
    def __init__(self):
        super(ORDERS, self).__init__()
        uic.loadUi('ORDERsTATUS.ui', self)
        self.populate_orders_table()
        self.selected_row=None
        self.filterDateButton.clicked.connect(self.filterItems)
        self.AdminOrderStatusTable.cellClicked.connect(self.row_selected)
        self.pushButton.clicked.connect(self.update_shipdate)
    def row_selected(self):

        self.selected_row = self.AdminOrderStatusTable.currentRow()
        
    def update_shipdate(self):
        shipped_date = self.dateTimeEdit.dateTime().toPyDateTime()
       
        if self.selected_row is not None:
            selected_row=self.selected_row
            if shipped_date:
               order_id = self.AdminOrderStatusTable.item(selected_row, 0).text()
               connection = pyodbc.connect(connection_string)
               cursor = connection.cursor()
               cursor.execute("SELECT orderdate FROM orders WHERE orderid = ?", order_id)
               order_date = cursor.fetchone()[0]

               if shipped_date >= order_date:
                  cursor.execute("UPDATE orders SET shippeddate = ? WHERE orderid = ?", shipped_date, order_id)
                  item = QTableWidgetItem(str(shipped_date))
                  self.AdminOrderStatusTable.setItem(selected_row, 2, item)
                  connection.commit()
                  connection.close()

               else:
                   QMessageBox.warning(self, "Error", "Shipped date cannot be earlier than order date.")
                   connection.close()
            else:
               QMessageBox.warning(self, 'Error', 'Select Shipped date!')
        else:
            QMessageBox.warning(self, 'Error', 'Select an order from the Table!')


    def filterItems(self):
        selecteddate = self.ShipDatecomboBox.currentText()

        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()

        if selecteddate == 'All':
           
            cursor.execute("select orderid,customerid,shippeddate from orders")    
        elif selecteddate == 'Shipped':
            cursor.execute("select orderid,customerid,shippeddate from orders where shippeddate is not null")
        else:
            cursor.execute("select orderid,customerid,shippeddate from orders where shippeddate is null")
        # Clear existing rows in the table
        self.AdminOrderStatusTable.setRowCount(0)

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.AdminOrderStatusTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.AdminOrderStatusTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.AdminOrderStatusTable.horizontalHeader()
        for i in range(self.AdminOrderStatusTable.columnCount()):
            header.setSectionResizeMode(
                i, QHeaderView.ResizeMode.ResizeToContents)
    def populate_orders_table(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("select orderid,customerid,shippeddate from orders")

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.AdminOrderStatusTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.AdminOrderStatusTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.AdminOrderStatusTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)

class DistributorDetailsUI(QtWidgets.QMainWindow):
    def __init__(self):
        super(DistributorDetailsUI, self).__init__()
        uic.loadUi('DistributorDetails.ui', self)
        self.populate_distributor_table()

        self.lineedit1 = self.findChild(QLineEdit, 'lineEdit')
        self.lineedit2 = self.findChild(QLineEdit, 'lineEdit_2')
        self.lineedit3 = self.findChild(QLineEdit, 'lineEdit_3')
        self.insert_button = self.findChild(QPushButton, 'pushButton')
        self.insert_button.clicked.connect(self.insert_data)

    def insert_data(self):
        # Get the text from line edits
        dcompanyname = self.lineedit1.text()
        dname = self.lineedit2.text()
        dphone = self.lineedit3.text()

        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("INSERT INTO Distributor (CompanyName, Name, Phone) VALUES (?, ?, ?)",
                       (dcompanyname, dname, dphone))
        connection.commit()
        cursor.execute(
            "SELECT max(DistributorId) AS distributorid from Distributor")
        result = cursor.fetchone()
        distributorid = result[0]
        connection.close()
        # Add a new row to the QTableWidget
        d_id = str(distributorid)

        # Insert a new row in the table on the screen
        row_position = self.DistributorTable.rowCount()
        self.DistributorTable.insertRow(row_position)
        self.DistributorTable.setItem(row_position, 0, QTableWidgetItem(d_id))
        self.DistributorTable.setItem(
            row_position, 1, QTableWidgetItem(dcompanyname))
        self.DistributorTable.setItem(row_position, 2, QTableWidgetItem(dname))
        self.DistributorTable.setItem(
            row_position, 3, QTableWidgetItem(dphone))

        # Adjust content display
        header = self.DistributorTable.horizontalHeader()
        for i in range(self.DistributorTable.columnCount()):
            header.setSectionResizeMode(
                i, QHeaderView.ResizeMode.ResizeToContents)
        QMessageBox.information(
            self, "Success", f"Distributor inserted successfully.")
        self.lineedit1.clear()
        self.lineedit2.clear()
        self.lineedit3.clear()

    def populate_distributor_table(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("select * from Distributor")

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.DistributorTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.DistributorTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.DistributorTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)


class WarehouseUI(QtWidgets.QMainWindow):
    def __init__(self):
        super(WarehouseUI, self).__init__()
        uic.loadUi('warehouseinfo.ui', self)
        self.populate_warehouse_table()
        self.selected_warehouse_id = None  # To store the selected warehouse ID
        self.WarehouseTable.cellClicked.connect(
            self.store_selected_data)  # Connect to a new method
        self.selectWarehouse.clicked.connect(self.handle_inventory)
        # self.WarehouseTable.cellClicked.connect(self.handle_inventory)

    def populate_warehouse_table(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("select * from Warehouse")

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.WarehouseTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.WarehouseTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.WarehouseTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)

    def store_selected_data(self, row, column):
        # Store the selected warehouse ID when a row is clicked
        self.selected_warehouse_id = self.WarehouseTable.item(row, 0).text()

    def handle_inventory(self):
        if self.selected_warehouse_id is not None:
            self.view_form_window = Inventory(self.selected_warehouse_id)
            self.view_form_window.show()
            # self.hide()
        else:
            print("No warehouse selected. Please click a row first.")


class Inventory(QtWidgets.QMainWindow):
    def __init__(self, warehouse_id):
        super(Inventory, self).__init__()
        uic.loadUi('inventory.ui', self)
        self.warehouse_id = warehouse_id
        self.populate_inventory_table(warehouse_id)
        self.selected_item_id = None
        self.ItemID.mousePressEvent = self.open_item_window
        self.updateButton.clicked.connect(self.update_selected_item)
        self.insertButton.clicked.connect(self.insert_new_item)

     
        self.inventorytable.cellClicked.connect(self.row_selected)

    def insert_new_item(self):
     
        itemid = self.ItemID.text()
        size = self.size.currentText()
        color = self.color.text()
        unitstock = self.Unitstock.text()
        reorder = self.reorder.text()
        discontinued = self.discontinued.text()

        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        query = """INSERT INTO Item_Inventory
            ([itemid],[size],[color],[unitsinstock],[reorderlevel],[discontinued])
            VALUES (?,?,?,?,?,?)
            """
        # Prepare and execute the SQL query to insert data into the 'Seller' table
        cursor.execute(query, (itemid, size, color,
                       unitstock, reorder, discontinued))

        connection.commit()
        cursor.execute("SELECT max(barcode) AS barcode from item_inventory")
        result = cursor.fetchone()
        barcode = result[0]
        connection.close()
        self.update_data(barcode, itemid, size, color,
                         unitstock, reorder, discontinued)

    def update_data(self, barcode, itemid, size, color, unitstock, reorder, discontinued):

        # Add a new row to the QTableWidget
        barcode_str = str(barcode)
        row_position = self.inventorytable.rowCount()
        self.inventorytable.insertRow(row_position)

        # Populate the new row with the retrieved data
        self.inventorytable.setItem(
            row_position, 0, QTableWidgetItem(barcode_str))
        self.inventorytable.setItem(row_position, 1, QTableWidgetItem(itemid))
        self.inventorytable.setItem(row_position, 2, QTableWidgetItem(size))
        self.inventorytable.setItem(row_position, 3, QTableWidgetItem(color))
        self.inventorytable.setItem(
            row_position, 4, QTableWidgetItem(unitstock))
        self.inventorytable.setItem(row_position, 5, QTableWidgetItem(reorder))
        self.inventorytable.setItem(
            row_position, 6, QTableWidgetItem(discontinued))

        QMessageBox.information(
            self, "Success", f"Item inserted successfully.")
        self.ItemID.clear()
        self.color.clear()
        self.Unitstock.clear()
        self.reorder.clear()
        self.discontinued.clear()

        # Update the database with the new data
    def update_selected_item(self):
        # Get values from your QLineEdits and QComboBoxes
        updated_values = [

            self.size.currentText(),
            self.color.text(),
            self.Unitstock.text(),
            self.reorder.text(),
            self.discontinued.text()
        ]

        # Update the selected row in the table
        selected_row = self.inventorytable.currentRow()
        for col, value in enumerate(updated_values):
            item = QTableWidgetItem(str(value))
          
            self.inventorytable.setItem(selected_row, col + 2, item)
        self.ItemID.clear()
        self.color.clear()
        self.Unitstock.clear()
        self.reorder.clear()
        self.discontinued.clear()
     
        self.update_database(self.selected_item_id, updated_values)

    def update_database(self, item_id, updated_values):

        # Establish a connection to the database
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()

    
        query = """
            UPDATE Item_Inventory
            SET size = ?, color = ?, unitsinstock = ?, reorderlevel = ?, discontinued = ?
            WHERE barcode = ?
        """

        # Execute the SQL query with the updated values
        cursor.execute(query, (*updated_values, item_id))

        # Commit the transaction
        connection.commit()

        # Close the database connection
        connection.close()
        QMessageBox.information(
            self, "Success", f"Item with barcode {item_id} updated successfully.")

    def populate_inventory_table(self, warehouse_id):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        # cursor.execute(cursor.execute("select * from Item_Inventory where WarehouseID = ?", warehouse_id)
        # print(f"SQL Query: select * from Item_Inventory where WarehouseID = ?", self.warehouse_id)
        cursor.execute(
            "select * from Item_Inventory where WarehouseID = ?", (self.warehouse_id,))
        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.inventorytable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.inventorytable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.inventorytable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(4, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(5, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(6, QHeaderView.ResizeMode.ResizeToContents)

    def open_item_window(self, event):
        # Simulate a mouse click event to trigger the item window
        if event.button() == Qt.MouseButton.LeftButton:
            self.item_window = Item(parent=self)
            self.item_window.show()

    def row_selected(self, row, column):

        selected_item_id = self.inventorytable.item(row, 0).text()

        other_column_values = [self.inventorytable.item(row, col).text(
        ) for col in range(1, self.inventorytable.columnCount())]

       
        self.ItemID.setText(other_column_values[0])
        self.size.setCurrentText(other_column_values[1])
        self.color.setText(other_column_values[2])
        self.Unitstock.setText(other_column_values[3])
        self.reorder.setText(other_column_values[4])
        self.discontinued.setText(other_column_values[5])


#######################
# Insert Items
class Item(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        super(Item, self).__init__(parent)
        uic.loadUi('Iteminsert.ui', self)
        self.populate_item_table()

        self.categoryDropdown.currentIndexChanged.connect(
            self.update_category_id)
        self.CollectionDropdown.currentIndexChanged.connect(
            self.update_category_id)
        self.insertButton.clicked.connect(self.insert_item)

    def populate_item_table(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("select * from items")

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.itemtable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.itemtable.setItem(row_index, col_index, item)

        # Close the database connection
        self.itemtable.cellClicked.connect(self.row_selected)
        connection.close()

        # Adjust content display
        header = self.itemtable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(4, QHeaderView.ResizeMode.Stretch)

    def row_selected(self, row, column):
        # Assuming the ItemID is in the first column (column index 0)
        selected_item_id = self.itemtable.item(row, 0).text()
        # Assuming the parent is the Inventory window
        if self.parent() is not None and isinstance(self.parent(), Inventory):
            confirmation = QMessageBox.question(
                self,
                "Confirmation",
                f"Do you want to select item {selected_item_id}?",
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.No,
                QMessageBox.StandardButton.No
            )
            if confirmation == QMessageBox.StandardButton.Yes:
                self.parent().ItemID.setText(selected_item_id)
                self.close()

    def update_category_id(self):
        # Get the selected category name and collection
        selected_category_name = self.categoryDropdown.currentText()
        selected_collection = self.CollectionDropdown.currentText()

    # Check if both category and collection are selected
        if selected_category_name and selected_collection:
            # Query the database to find the corresponding category ID
            connection = pyodbc.connect(connection_string)
            cursor = connection.cursor()
            cursor.execute("SELECT CategoryID FROM Categories WHERE CategoryName = ? AND Collection = ?",
                           (selected_category_name, selected_collection))

        # Fetch the result
            result = cursor.fetchone()

        # Close the database connection
            connection.close()

       
            if result is not None:
                category_id = result[0]
                self.categoryIDLine.setText(str(category_id))
            else:
               
                QMessageBox.warning(self, "Category Not Found",
                                    f"No Category found for {selected_category_name} in {selected_collection}")
         
                self.categoryIDLine.clear()
        else:
            # Display a message box if either category or collection is not selected
            QMessageBox.warning(self, "Selection Error",
                                "Please select both Category and Collection.")

            self.categoryIDLine.clear()

    def insert_item(self):
        # Get values from the UI
        item_name = self.itemName.text()
        category_id = self.categoryIDLine.text()
        unit_price = self.unitPrice.text()
        description = self.description.text()
        collection = self.CollectionDropdown.currentText()

        # Check if all required fields are selected
        if item_name and category_id and unit_price and collection:
            # Perform the database insertion
            connection = pyodbc.connect(connection_string)
            cursor = connection.cursor()

            # Adjust the SQL query based on your database schema
            cursor.execute("INSERT INTO ITEMS (ItemName, CategoryID,collection, UnitPrice, Description) "
                           "VALUES (?, ?, ?, ?,?)", (item_name, category_id, collection, unit_price, description))

            # Commit the transaction
            connection.commit()
            cursor.execute("SELECT max(itemid) AS itemid from items")
            result = cursor.fetchone()
            item_id = result[0]
            connection.close()
            self.update_data(item_id, item_name, category_id,
                             collection, unit_price, description)

            # Display a success message
            QMessageBox.information(
                self, "Item Inserted", "Item has been successfully inserted.")
        else:
            # Display an error message if any required field is missing
            QMessageBox.warning(self, "Insertion Error",
                                "Please fill in all required fields.")

    def update_data(self, item_id, item_name, category_id, collection, unit_price, description):

        # Add a new row to the QTableWidget
        item_id_str = str(item_id)
        row_position = self.itemtable.rowCount()
        self.itemtable.insertRow(row_position)

        # Populate the new row with the retrieved data
        self.itemtable.setItem(row_position, 0, QTableWidgetItem(item_id_str))
        self.itemtable.setItem(row_position, 1, QTableWidgetItem(item_name))
        self.itemtable.setItem(row_position, 2, QTableWidgetItem(category_id))
        self.itemtable.setItem(row_position, 3, QTableWidgetItem(collection))
        self.itemtable.setItem(row_position, 4, QTableWidgetItem(unit_price))
        self.itemtable.setItem(row_position, 5, QTableWidgetItem(description))

        self.itemName.clear()
        self.categoryIDLine.clear()
        self.unitPrice.clear()
        self.description.clear()

        


class SellerUI(QtWidgets.QMainWindow):
    def __init__(self):
        super(SellerUI, self).__init__()
        uic.loadUi('sellerinfo.ui', self)
        self.populate_seller_table()
        self.InsertSellerButton.clicked.connect(self.insert_seller_data)
        self.selected_seller_id = None
        self.sellerTable.cellClicked.connect(self.store_selected_data)
        self.materialDetail.clicked.connect(self.handle_material)
# we will have to edit the following code, because we will have different inventory page for different warehouse

    def populate_seller_table(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("select * from Seller")

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.sellerTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.sellerTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.sellerTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)

    def insert_seller_data(self):
        # Establish a connection to the database
        company_name = self.SellerName.text()
        seller_contact = self.SellerContact.text()
        warehouse_location = self.SellerLocation.text()
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        query = """INSERT INTO Seller
            ([CompanyName],[SellerContact],[WarehouseLocation])
            VALUES (?,?,?)
            """
        # Prepare and execute the SQL query to insert data into the 'Seller' table
        cursor.execute(
            query, (company_name, seller_contact, warehouse_location))

        connection.commit()
        cursor.execute("SELECT max(sellerid) AS sellerid from seller")
        result = cursor.fetchone()
        seller_id = result[0]
        connection.close()
        self.update_data(seller_id, company_name,
                         seller_contact, warehouse_location)

    def update_data(self, seller_id, company_name, seller_contact, warehouse_location):

        # Add a new row to the QTableWidget
        seller_id_str = str(seller_id)
        row_position = self.sellerTable.rowCount()
        self.sellerTable.insertRow(row_position)

        # Populate the new row with the retrieved data
        self.sellerTable.setItem(
            row_position, 0, QTableWidgetItem(seller_id_str))
        self.sellerTable.setItem(
            row_position, 1, QTableWidgetItem(company_name))
        self.sellerTable.setItem(
            row_position, 2, QTableWidgetItem(seller_contact))
        self.sellerTable.setItem(
            row_position, 3, QTableWidgetItem(warehouse_location))
        QMessageBox.information(self, "Seller Inserted",
                                "Seller has been successfully inserted.")
        self.SellerName.clear()
        self.SellerContact.clear()
        self.SellerLocation.clear()
        # Update the database with the new data

    def store_selected_data(self, row, column):
        # Store the selected warehouse ID when a row is clicked
        self.selected_seller_id = self.sellerTable.item(row, 0).text()

    def handle_material(self):
        if self.selected_seller_id is not None:
            self.view_form_window = Material(self.selected_seller_id)
            self.view_form_window.show()

        else:
            print("No material selected. Please click a row first.")


class Material(QtWidgets.QMainWindow):
    def __init__(self, seller_id):
        super(Material, self).__init__()
        uic.loadUi('materialinfo.ui', self)
        self.seller_id = seller_id
        self.populate_material_table(seller_id)
        self.UpdateButton.clicked.connect(self.update_units_in_stock)

    def populate_material_table(self, seller_id):

        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        # cursor.execute(cursor.execute("select * from Item_Inventory where WarehouseID = ?", warehouse_id)
        # print(f"SQL Query: select * from Item_Inventory where WarehouseID = ?", self.warehouse_id)
        cursor.execute(
            "select * from Material where SellerID = ?", (self.seller_id,))
        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.MaterialinfoTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.MaterialinfoTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.MaterialinfoTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(4, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(5, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(6, QHeaderView.ResizeMode.ResizeToContents)

    def update_units_in_stock(self):
        material_id = self.MaterialIDText.text()
        new_units = self.UnitsInStock.text()

        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()

        # Execute the SQL UPDATE statement with parameters
        cursor.execute("UPDATE Material SET UnitsInStock_after = ? WHERE MaterialID = ? AND SellerID = ?",
                       (new_units, material_id, self.seller_id))

        # Commit the transaction
        connection.commit()

        for row_index in range(self.MaterialinfoTable.rowCount()):
            material_id_item = self.MaterialinfoTable.item(row_index, 0)
            units_in_stock_item = self.MaterialinfoTable.item(row_index, 5)

            if material_id_item and material_id_item.text() == material_id:
                # Update the UnitsInStock cell
                units_in_stock_item.setText(new_units)
        QMessageBox.information(self, "Material updated",
                                "Material has been successfully updated.")
        self.MaterialIDText.clear()
        self.UnitsInStock.clear()
        # Close the database connection in the 'finally' block to ensure it's closed even if an error occurs
        connection.close()


########################
class CustomerUI(QtWidgets.QMainWindow):
    def __init__(self):
        super(CustomerUI, self).__init__()
        uic.loadUi('customerDetail.ui', self)
        self.populate_customer_table()
        self.selected_customer_id = None  # To store the selected warehouse ID
        self.customerTable.cellClicked.connect(
            self.store_selected_data)  # Connect to a new method
        self.C_od.clicked.connect(self.handle_Orderhistory)

    def populate_customer_table(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("select * from Customers")

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.customerTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.customerTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.customerTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.Stretch)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(4, QHeaderView.ResizeMode.ResizeToContents)

    def handle_Orderhistory(self):
        if self.selected_customer_id is not None:
            self.view_form_window = OrderHistoryUI(self.selected_customer_id)
            self.view_form_window.show()
            # self.hide()

    def store_selected_data(self, row, column):
        # Store the selected warehouse ID when a row is clicked
        self.selected_customer_id = self.customerTable.item(row, 0).text()


class OrderHistoryUI(QtWidgets.QMainWindow):
    def __init__(self, customerid):
        super(OrderHistoryUI, self).__init__()
        uic.loadUi('orderHistory.ui', self)
        self.customerid = customerid
        self.populate_orderhistory(customerid)
        self.selected_order_id = None  # To store the selected warehouse ID
        self.orderTable.cellClicked.connect(self.getOrderDetails)
        self.ViewOrderDetails.clicked.connect(self.showOrderDetails)

    def getOrderDetails(self, row, column):
        self.selected_order_id = self.orderTable.item(row, 0).text()

    def showOrderDetails(self):
        self.view_form_window = OrderDetailsUI(self.selected_order_id)
        self.view_form_window.show()

    def populate_orderhistory(self, customerid):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        # cursor.execute(cursor.execute("select * from Item_Inventory where WarehouseID = ?", warehouse_id)
        # print(f"SQL Query: select * from Item_Inventory where WarehouseID = ?", self.warehouse_id)
        cursor.execute(
            "select orderid,orderdate,shippeddate,shipvia from orders where customerid = ?", (self.customerid,))
        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.orderTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.orderTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.orderTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)

########################


class OrderDetailsUI(QtWidgets.QMainWindow):
    def __init__(self, orderid):
        super(OrderDetailsUI, self).__init__()
        uic.loadUi('OrderDetails.ui', self)
        self.orderid = orderid
        self.populate_orderdetails(orderid)

    def populate_orderdetails(self, orderid):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        # cursor.execute(cursor.execute("select * from Item_Inventory where WarehouseID = ?", warehouse_id)
        # print(f"SQL Query: select * from Item_Inventory where WarehouseID = ?", self.warehouse_id)
        cursor.execute(
            "select * from [order details] where orderid = ?", (self.orderid,))
        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.orderdetails.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.orderdetails.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.orderdetails.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(4, QHeaderView.ResizeMode.ResizeToContents)


class ComplaintUI(QtWidgets.QMainWindow):
    def __init__(self):
        super(ComplaintUI, self).__init__()
        uic.loadUi('complaint.ui', self)
        self.populate_complaints_table()
       
        self.label1 = self.findChild(QLineEdit, 'ComplaintIDText')
   
        self.label2 = self.findChild(QLineEdit, 'StatusText')
      
        self.update_button = self.findChild(
            QPushButton, 'ChangeStatuspushButton')
        self.update_button.clicked.connect(self.update_data)

    def update_data(self):
        # Get the updated text from labels
        complaint_id_text = self.label1.text()
        status_text = self.label2.text()
        if not complaint_id_text or not status_text:
            QMessageBox.warning(self, 'Error', 'Please fill the required boxes!')
            return
        # Update data in the table on the screen
        for row in range(self.complaintTable.rowCount()):
            if self.complaintTable.item(row, 0).text() == complaint_id_text:
                self.complaintTable.setItem(
                    row, 3, QTableWidgetItem(status_text))
                break

        # Update data in the database
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("UPDATE Complaints SET Resolved = ? WHERE ComplaintID = ?",
                       (status_text, complaint_id_text))
        connection.commit()
        connection.close()

    def populate_complaints_table(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("select * from Complaints")

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.complaintTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.complaintTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.complaintTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.Stretch)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(4, QHeaderView.ResizeMode.ResizeToContents)


# ------------------------------------------------------------------------------------------CUSTOMER

class A(QtWidgets.QMainWindow):
    def __init__(self):
        super(A, self).__init__()
        uic.loadUi('A.ui', self)
        self.menubutton.clicked.connect(self.handle_menu)
        self.profilebutton.clicked.connect(self.handle_profile)
        self.e_instance = E(self)

    def handle_menu(self):
        self.view_form_window = B(self, parent=self)
        self.view_form_window.show()

    def handle_profile(self):
        self.e_instance.show()
        # self.hide()
    # def cleartable():

class Complaint(QtWidgets.QMainWindow):
    def __init__(self,a_instance):
        super(Complaint, self).__init__()
        uic.loadUi('filingcomplaint.ui', self)
        self.a_instance=a_instance
        self.submitComplaint.clicked.connect(self.submit)
        
        self.backb2.clicked.connect(self.handleback)
    def handleback(self):
        self.a_instance.show()
        self.hide()


    def submit(self):
        self.complaintID=self.ComplaintID.text()
        self.complaint=self.Complaint.toPlainText()
        if self.complaintID and self.complaint and self.complaintID.isnumeric():

            connection = pyodbc.connect(connection_string)
            cursor = connection.cursor()
            cursor.execute("select orderid from orders where orderid=(?)", (int(self.complaintID)))
            result = cursor.fetchone()
            

            if result is not None:
               cursor.execute("INSERT into Complaints (OrderID, Complaint, Resolved) VALUES (?,?,?)", (int(self.complaintID), self.complaint,"n"))
               connection.commit()
               connection.close()
               QMessageBox.warning(self, 'Complaint submitted', 'Your Complaint will be resolved as soon as possible.\n Thankyou for your patience.')
            else:
               QMessageBox.warning(self, 'Error', 'Orderid not found!')
        elif not self.complaintID.isnumeric():
            QMessageBox.warning(self, 'Error', 'Orderid should be numeric')
        else:
            QMessageBox.warning(self, 'Error', 'Enter the details asked above to submit your Complaint.')


        
class B(QtWidgets.QMainWindow):
    def __init__(self, a_instance, parent=None):
        super(B, self).__init__(parent)
        print("hello")
        uic.loadUi('B.ui', self)
        self.setGeometry(360, 120, 262, 576)
        self.a_instance = a_instance
        self.summerbutton.clicked.connect(self.handle_summer)
        self.winterbutton.clicked.connect(self.handle_winter)
        self.yrbutton.clicked.connect(self.handle_yearround)
        self.complaintbutton.clicked.connect(self.handle_complaint)
    def handle_complaint(self):
        self.view_form_window=Complaint(self.a_instance)
        self.view_form_window.show()
        if self.parent():
            self.parent().hide()
        self.hide()
    def handle_summer(self):
        self.season = "summer"
        self.view_form_window = C(self.season, self.a_instance)
        self.view_form_window.show()
        if self.parent():
            self.parent().hide()
        self.hide()

    def handle_winter(self):
        self.season = "winter"
        self.view_form_window = C(self.season, self.a_instance)
        self.view_form_window.show()
        if self.parent():
            self.parent().hide()
        self.hide()

    def handle_yearround(self):
        self.season = "all"
        self.view_form_window = C(self.season, self.a_instance)
        self.view_form_window.show()
        if self.parent():
            self.parent().hide()
        self.hide()


class C(QtWidgets.QMainWindow):
    def __init__(self, season, a_instance):
        super(C, self).__init__()
        uic.loadUi('C.ui', self)
        self.a_instance = a_instance
        
        self.season = season
        self.categoryComboBox = self.findChild(QComboBox, 'categcomboBox')
        self.filterButton = self.findChild(QPushButton, 'filterbutton')
        self.populateCategoryDropdown()
        self.populateItemTable(season)
        self.filterButton.clicked.connect(self.filterItems)
        self.viewitembutton.clicked.connect(self.viewSelectedItem)
        self.itemSelectTable.cellClicked.connect(self.handleCellClick)
        self.menubutton.clicked.connect(self.handle_menu)
        self.profilebutton.clicked.connect(self.handle_profile)
        self.backb1.clicked.connect(self.handle_back)

    def handle_back(self):

        self.a_instance.show()
        self.hide()

    def handleCellClick(self, row, column):
       
        category_id_item = self.itemSelectTable.item(row, 2)
        if category_id_item:
            selected_category_id = category_id_item.text()
            # Set the selected category in the dropdown
            index = self.categoryComboBox.findText(selected_category_id)
            if index != -1:
                self.categoryComboBox.setCurrentIndex(index)

    def viewSelectedItem(self):
        selected_item_id = self.getSelectedItemId()
        if selected_item_id:
            self.view_form_window = D(
                selected_item_id, self.a_instance, self.season)
            self.view_form_window.show()
            self.hide()

    def getSelectedItemId(self):
        current_row = self.itemSelectTable.currentRow()
        if current_row != -1:
          
            item_id_item = self.itemSelectTable.item(current_row, 0)
            if item_id_item:
                print(item_id_item.text())
                return item_id_item.text()

      
        QMessageBox.warning(self, 'Warning', 'No item selected.')
        return None



    def populateCategoryDropdown(self):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("SELECT categoryname FROM categories ORDER BY categoryid ASC")

    # Fetch category IDs and populate the dropdown
        categories = ["All"] 
        categories.extend([str(row_data[0]) for row_data in cursor.fetchall()])

        self.categoryComboBox.addItems(categories)
        connection.close()

    def filterItems(self):
        selected_category_name = self.categoryComboBox.currentText()

        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        if selected_category_name=='All':
            if self.season == "summer":
                cursor.execute(
                "SELECT ItemID, ItemName, categoryid, UnitPrice, Description FROM Items WHERE Collection LIKE 'Summer'")
            elif self.season == "winter":
                cursor.execute(
                "SELECT ItemID, ItemName, categoryid, UnitPrice, Description FROM Items WHERE Collection LIKE 'Winter' ")
            else:
                cursor.execute(
                "SELECT ItemID, ItemName, categoryid, UnitPrice, Description FROM Items WHERE Collection LIKE 'Year-Round'")
    
        else:
            cursor.execute("select categoryid from categories where categoryname like ?",selected_category_name)
            selected_category_id=cursor.fetchall()[0]
            if self.season == "summer":
                cursor.execute(
                "SELECT ItemID, ItemName, categoryid, UnitPrice, Description FROM Items WHERE Collection LIKE 'Summer' AND categoryid = ?", selected_category_id)
            elif self.season == "winter":
                cursor.execute(
                "SELECT ItemID, ItemName, categoryid, UnitPrice, Description FROM Items WHERE Collection LIKE 'Winter' AND categoryid = ?", selected_category_id)
            else:
                cursor.execute(
                "SELECT ItemID, ItemName, categoryid, UnitPrice, Description FROM Items WHERE Collection LIKE 'Year-Round' AND categoryid = ?", selected_category_id)

        # Clear existing rows in the table
        self.itemSelectTable.setRowCount(0)

        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.itemSelectTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.itemSelectTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.itemSelectTable.horizontalHeader()
        for i in range(self.itemSelectTable.columnCount()):
            header.setSectionResizeMode(
                i, QHeaderView.ResizeMode.ResizeToContents)

    def populateItemTable(self, season):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        if season == "summer":
            cursor.execute(
                "select ItemID, ItemName,categoryid, UnitPrice, Description from Items where Collection like 'Summer'")
        elif season == "winter":
            cursor.execute(
                "select ItemID, ItemName,categoryid, UnitPrice, Description from Items where Collection like  'Winter'")
        else:
            cursor.execute(
                "select ItemID, ItemName,categoryid, UnitPrice, Description from Items where Collection like 'Year-Round'")
        # Fetch all rows and populate the table
        for row_index, row_data in enumerate(cursor.fetchall()):
            self.itemSelectTable.insertRow(row_index)
            for col_index, cell_data in enumerate(row_data):
                item = QTableWidgetItem(str(cell_data))
                self.itemSelectTable.setItem(row_index, col_index, item)

        # Close the database connection
        connection.close()

        # Adjust content display
        header = self.itemSelectTable.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)

    def handle_menu(self):
        self.view_form_window = B(self.a_instance, parent=self)
        self.view_form_window.show()

    def handle_profile(self):
        self.a_instance.e_instance.setparent(self)
        self.a_instance.e_instance.show()
        self.hide()


class D(QtWidgets.QMainWindow):

    cart_updated = pyqtSignal(int,int, int, float)

    def __init__(self, itemid, a_instance, season):
        super(D, self).__init__()
        uic.loadUi('D.ui', self)
        self.a_instance = a_instance
        self.a_instance.e_instance.setparent(self)
        self.season = season
        self.itemid = itemid
        self.addtocartbutton.clicked.connect(self.handle_cart)
        self.menubutton.clicked.connect(self.handle_menu)
        self.profilebutton.clicked.connect(self.handle_profile)
        self.backb2.clicked.connect(self.handle_back1)
        self.sizeComboBox = self.findChild(QComboBox, 'sizecomboBox')
        self.colorComboBox = self.findChild(QComboBox, 'colorcomboBox')
        self.quantityLineEdit = self.findChild(QLineEdit, 'lineEdit')
        self.populateSizeColorDropdowns(itemid)

        # self.cart_ui = E()

        self.cart_updated.connect(self.a_instance.e_instance.update_cart)

    def populateSizeColorDropdowns(self, item_id):
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        # Fetch distinct sizes and colors for the given item ID
        cursor.execute(
            "SELECT DISTINCT Size FROM Item_Inventory WHERE ItemID = ?", item_id)
        sizes = [row[0] for row in cursor.fetchall()]
        self.sizeComboBox.addItems(sizes)

        cursor.execute(
            "SELECT DISTINCT CAST(Color AS NVARCHAR(MAX)) FROM Item_Inventory WHERE ItemID = ?", item_id)
        colors = [row[0] for row in cursor.fetchall()]
        self.colorComboBox.addItems(colors)

        # Close the database connection
        connection.close()

    def handle_back1(self):
        self.view_form_window = C( self.season,self.a_instance,)
        self.view_form_window.show()
        self.hide()

    def handle_menu(self):
        self.view_form_window = B(parent=self)
        self.view_form_window.show()

    def handle_profile(self):
        self.a_instance.e_instance.setparent(self)
        self.a_instance.e_instance.show()
        self.hide()

    def handle_cart(self):
        # Retrieve selected size, color, and quantity
        selected_size = self.sizeComboBox.currentText()
        selected_color = self.colorComboBox.currentText()
        # Convert quantity to integer

        # Check if size, color, and quantity are selected
        if not selected_size or not selected_color or self.quantityLineEdit.text() == '' or not self.quantityLineEdit.text().isnumeric():
            QMessageBox.warning(
                self, 'Warning', 'Please select size, color, and enter a valid quantity.')
            return
        # Fetch barcode from ItemInventory based on size, color, and item ID
        quantity = int(self.quantityLineEdit.text())
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        cursor.execute("SELECT Barcode FROM Item_Inventory WHERE ItemID = ? AND Size like ? AND Color like ?", int(
            self.itemid), selected_size, selected_color)
        result = cursor.fetchone()

        cursor.execute(
            "SELECT Unitsinstock FROM Item_Inventory WHERE Barcode= ?", result[0])
        result1 = cursor.fetchone()
        cursor.execute(
            "SELECT Discontinued FROM Item_Inventory WHERE Barcode= ?", result[0])
        result2 = cursor.fetchone()
        unitsinstock = int(result1[0])
        discontinued = (result2[0])
        if result and unitsinstock >= quantity and discontinued == 0:
            barcode_ = result[0]
            barcode = int(barcode_)
            # Fetch unit price from Item table based on item ID
            cursor.execute(
                "SELECT UnitPrice FROM Items WHERE ItemID = ?", self.itemid)
            result = cursor.fetchone()

            if result:
                unit_price = result[0]
                total_price = unit_price * quantity

                # Insert into the cart table
                cursor.execute("INSERT INTO Cart (Barcode, Quantity, TotalAmount) VALUES (?, ?, ?)",
                               barcode, quantity, total_price)
                cursor.execute(
            "SELECT max(cartid) FROM cart ")
                result = cursor.fetchone()
                cartid=result[0]
                connection.commit()

                self.cart_updated.emit(cartid,barcode, quantity, total_price)

                QMessageBox.information(
                    self, 'Success', 'Item added to the cart successfully.')
            else:
                QMessageBox.warning(
                    self, 'Error', 'Unable to fetch unit price for the selected item.')

        else:
            QMessageBox.warning(
                self, 'Error', 'No matching item found in inventory for the selected size and color.')

        # Close the database connection
        connection.close()

        # remove
        """self.cart_ui.show()
        self.hide()"""


# ui for cart, needs to be connected to main page
class E(QtWidgets.QMainWindow):
    def __init__(self, a_instance):
        super(E, self).__init__()
        uic.loadUi('E.ui', self)
        self.parentt=None
        self.parent_instance = a_instance
        self.delfromcart.clicked.connect(self.deleteitem)
        self.checkoutButton.clicked.connect(self.handle_checkout)
        self.backcart.clicked.connect(self.handle_backcart)
        self.cart_items = []
        self.tableWidget.cellClicked.connect(self.row_selected)
        self.selected_row=None
        self.cartid_list=[]
        self.selected_row_index=None
  
    def row_selected(self):
        self.selected_row_index = self.sender().currentRow()

        self.selected_row = self.tableWidget.currentRow()
    def deleteitem(self):
        if self.selected_row is not None:
           self.tableWidget.removeRow(self.selected_row)
           self.selected_row = None

      

           QMessageBox.warning(
                self, 'Success', 'Item successfully removed from the cart.')
        elif not self.cart_items:
            QMessageBox.warning(self, 'Error', 'Cart is Empty!')
        else:
            QMessageBox.warning(self, 'Error', 'Please select an item to delete.')


    def setparent(self,parentt):
        self.parentt=parentt
    def update_cart(self,cartid, barcode, quantity, total_price):
        # Add a new row to the table in the Cart UI
        
        row_position = self.tableWidget.rowCount()
        self.tableWidget.insertRow(row_position)
        self.cart_items.append(
            {'barcode': barcode, 'quantity': quantity, 'total_price': total_price})
        self.cartid_list+=[cartid]
        # Populate the cells with the provided values

        self.tableWidget.setItem(
            row_position, 0, QTableWidgetItem(str(barcode)))
        self.tableWidget.setItem(
            row_position, 1, QTableWidgetItem(str(quantity)))
        self.tableWidget.setItem(
            row_position, 2, QTableWidgetItem(str(total_price)))

        header = self.tableWidget.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.ResizeMode.ResizeToContents)
        header.setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)

    # back to main menu
    def handle_backcart(self):
        """self.view_form_window =D()
        self.view_form_window.show()"""
        if self.parentt==None:
           #print("Hello")
           self.parent_instance.show()
           self.hide()
        else:
            #print("World")
            self.view_form_window = C(self.parentt.season, self.parent_instance)
           
            self.view_form_window.show()
            self.hide()

    def handle_checkout(self):
        if self.tableWidget.rowCount()==0:
            QMessageBox.warning(
                self, 'Empty Cart', 'Your cart is empty. Add items before proceeding to checkout.')
        else:
            self.view_form_window = F(self.cart_items, self.parent_instance)
            self.view_form_window.show()
            self.hide()


class F(QtWidgets.QMainWindow):
    def __init__(self, cart_items, a_instance):
        super(F, self).__init__()
        uic.loadUi('F.ui', self)
        self.a_instance = a_instance
        self.confirmorder.clicked.connect(self.handle_order)
        self.backb4.clicked.connect(self.handle_backorder)
        self.cartitems = cart_items

    def handle_backorder(self):
        self.a_instance.e_instance.show()
        self.hide()

  

    def handle_order(self):
        name = self.name.text()
        email = self.email.text()
        address = self.address.text()
        city = self.city.text()
        region = self.region.text()
        postalcode = self.postalcode.text()
        phone = self.phone.text()
        paymentmethod = self.payment.currentText()
        customer_id = None
        connection = pyodbc.connect(connection_string)
        cursor = connection.cursor()
        if name and email and address and city and region and postalcode and phone and paymentmethod:
            query = "SELECT CustomerID FROM Customers WHERE customerName like ? AND (customerEmail like ? OR Phone like ? OR Address like ?)"
            cursor.execute(query, name, email, phone, address)
            result = cursor.fetchone()

            if result:
                # Customer exists, return the customer ID
                customer_id = result[0]
            if not customer_id:

                insert_query = "INSERT INTO Customers (customerName, customerEmail,Address,city,region,postalcode, Phone) VALUES (?, ?, ?,?,?,?,?)"
                cursor.execute(insert_query, name, email, address,
                               city, region, postalcode, phone)
                cursor.execute(
                    "SELECT max(customerid) as customerid from customers")
                result = cursor.fetchone()
                customerid = result[0]
            cursor.execute("SELECT max(distributorid) from distributor")
            result = cursor.fetchone()
            max = result[0]
            num = random.randint(1, max)

            query = "SELECT distributorid from distributor where distributorid=?"
            cursor.execute(query, num)
            result = cursor.fetchone()
            shipvia = result[0]

       
            insert_query = "INSERT INTO orders (customerid, orderdate, shippeddate, shipvia, shipAddress, shipcity, shipregion, shippostalcode) VALUES (?, GETDATE(), ?, ?, ?, ?, ?, ?)"
            cursor.execute(insert_query, customerid, None,
                           shipvia, address, city, region, postalcode)

        # Fetch the customer ID of the newly inserted record
            cursor.execute("SELECT max(orderid) as orderid from orders")
            result = cursor.fetchone()
            orderid = result[0]
            for orderdetails in self.cartitems:
                barcode = orderdetails['barcode']
                quantity = orderdetails['quantity']
                totalprice = orderdetails['total_price']
                cursor.execute("INSERT INTO [order details] (orderid,barcode, quantity, unitprice,paymentmethod) VALUES (?, ?, ?,?,?)",
                               (orderid, barcode, quantity, totalprice, paymentmethod))
                cursor.execute("update item_inventory set unitsinstock=unitsinstock-? where barcode=?",(quantity,barcode,))

            connection.commit()
            connection.close()
            self.view_form_window = G(orderid, self.a_instance)
            self.view_form_window.show()
            self.hide()
        else:
            QMessageBox.warning(self, 'Error', 'Please enter all the details.')


class G(QtWidgets.QMainWindow):
    def __init__(self, orderid, a_instance):
        super(G, self).__init__()
        uic.loadUi('G.ui', self)
        self.orderid = orderid
        self.a_instance = a_instance
        self.DisplayOrderId.setEnabled(False)
        self.DisplayOrderId.setText(str(orderid))
        self.mmbutton.clicked.connect(self.handle_backtomenu)

    def handle_backtomenu(self):
        self.view_form_window = A()
        self.view_form_window.show()
        self.hide()


class P(QtWidgets.QMainWindow):
    def __init__(self):
        super(P, self).__init__()
        uic.loadUi('P.ui', self)
        self.backb4.clicked.connect(self.handle_back)

    def handle_back(self):
        self.view_form_window = A()
        self.view_form_window.show()
        self.hide()


app = QtWidgets.QApplication(sys.argv)
window = UI()

app.exec()
