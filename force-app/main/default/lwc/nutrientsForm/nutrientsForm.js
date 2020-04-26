import { LightningElement, track, api, wire } from 'lwc';
//import { CurrentPageReference } from 'lightning/navigation';
import getRecipesByCarbs from '@salesforce/apex/RecipeController.getRecipesByCarbs'; 
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class NutrientsForm extends LightningElement {
    @track selectedNutrient;
    @track min;
    @track max;
    @track recipesLoaded = false;
    @track noRecipes = false;
    @track inputMode = true;
    //@wire(CurrentPageReference) pageRef;
    //@track isSelected = false;
    
    get options() {
        return [
            { label: 'Carbohydrate', value: 'Carbs' },
            { label: 'Protein', value: 'Protein' },
            { label: 'Calories', value: 'Calories' },
        ];
    }

    handleChange(event) {
        //this.isSelected = true;
        this.selectedNutrient = event.detail.value;
        }

    handleInput(event) {
        let maxInput = this.template.querySelector(".inputMax");
        if(event.target.name === 'min') this.min = event.target.value;
        else if(event.target.name === 'max') this.max = event.target.value;
    }

    handleReset(event) {
        //location.reload();
        console.log('handling reset....');
        //console.log(this.template.getElementById('inputMin'));
        this.recipesLoaded = false;
        this.noRecipes = false;
        this.inputMode = true;
        //this.template.getElementById('inputMin').value = '';
        //this.template.getElementById('inputMax').value = '';
    }

    handleClick() {
        getRecipesByCarbs({nutrient:this.selectedNutrient,min:this.min, max:this.max})
            .then(result => {
                console.log(result);
                if(result.length !== 0) { 
                    this.recipes = result;
                    this.recipesLoaded = true;
                    this.noRecipes = false;
                    this.inputMode = false; 
                }
                else {
                    this.inputMode = false;
                    this.noRecipes = true;
                }
                
            })
            .catch(error => {
                this.error = error;
                console.log(this.error);
            });
        
    }

    showNotification(toastMessage) {
        const evt = new ShowToastEvent({
            title: this._title,
            message: toastMessage,
            variant: this.variant,
        });
        this.dispatchEvent(evt);
    }
}
    

