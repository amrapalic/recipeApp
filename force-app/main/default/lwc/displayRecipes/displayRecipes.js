import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners, fireEvent } from 'c/pubsub';

export default class DisplayRecipes extends LightningElement {
    recipes;
    noRecipes = false;

    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener('recipesLoaded', this.handleRecipesLoad, this);
    }

    disconnectedCallback() {
        unregisterAllListeners(this);
    }

    handleRecipesLoad(recipes) { 
        if(recipes.length !== 0) {
            this.recipes = recipes; 
        }
        else {
            this.noRecipes = true;
        }
        
    }
}